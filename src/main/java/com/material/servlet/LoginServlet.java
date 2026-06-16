package com.material.servlet;

import com.material.bean.SysUser;
import com.material.bean.OperateLog;
import com.material.dao.SysUserDao;
import com.material.dao.OperateLogDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SysUserDao userDao = new SysUserDao();
    private OperateLogDao logDao = new OperateLogDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. 调用DAO登录（密码加密已经在Dao层处理了，这里直接传明文）
        SysUser user = userDao.login(username, password);
        if (user != null) {
            // 3. 登录成功，存入Session
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // 和你原来的属性名保持一致

            // 4. 记录操作日志
            logDao.add(new OperateLog(user.getUsername(), "登录系统"));

            // 5. 按角色跳转（已全部改为走Servlet控制器，登录即加载数据）
            String role = user.getRole();
            String contextPath = request.getContextPath(); // 获取项目上下文路径，避免404
            switch (role) {
                case "admin":
                    // 改为走管理员工作台Servlet，先查数据再渲染页面
                    response.sendRedirect(contextPath + "/admin/index");
                    break;
                case "采购人":
                    // 改为走采购人工作台Servlet
                    response.sendRedirect(contextPath + "/purchaser/index");
                    break;
                case "审批人":
                    // 改为走审批人工作台Servlet
                    response.sendRedirect(contextPath + "/approver/index");
                    break;
                default:
                    request.setAttribute("errorMsg", "用户身份异常");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            // 6. 登录失败，跳回登录页并显示错误信息
            request.setAttribute("errorMsg", "用户名或密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}