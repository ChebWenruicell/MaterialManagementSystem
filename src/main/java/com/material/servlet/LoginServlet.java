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

            // 5. ✅ 修正跳转路径+补全审批人角色
            String role = user.getRole();
            String contextPath = request.getContextPath(); // 获取项目上下文路径，避免404
            switch (role) {
                case "admin":
                    response.sendRedirect(contextPath + "/admin/index.jsp");
                    break;
                case "采购人":
                    response.sendRedirect(contextPath + "/purchaser/index.jsp"); // ✅ 修正路径
                    break;
                case "审批人":
                    response.sendRedirect(contextPath + "/approver/index.jsp"); // ✅ 补全审批人
                    break;
                default:
                    request.setAttribute("errorMsg", "用户身份异常");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            // 6. ✅ 登录失败，跳回登录页并显示错误信息（和你login.jsp里的errorMsg对应）
            request.setAttribute("errorMsg", "用户名或密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}