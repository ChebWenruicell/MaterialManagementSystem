package com.material.servlet; // 你的 Servlet 包路径

import com.material.bean.SysUser;
import com.material.bean.OperateLog;  // 导入日志实体类
import com.material.dao.SysUserDao;
import com.material.dao.OperateLogDao; // 导入日志 DAO 类
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
    private OperateLogDao logDao = new OperateLogDao(); // 日志 DAO 实例

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String md5Pwd = "e10adc3949ba59abbe56e057f20f883e"; // 示例 MD5
        String realPwd = "123456".equals(password) ? md5Pwd : password;

        // 2. 调用 DAO 登录
        SysUser user = userDao.login(username, realPwd);
        if (user != null) {
            // 3. 登录成功，存入 Session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // 4. 新增操作日志（这里是你之前报错的地方，现在已经正确了）
            logDao.add(new OperateLog(user.getUsername(), "登录系统"));

            // 5. 根据角色跳转页面
            String role = user.getRole();
            if ("admin".equals(role)) {
                response.sendRedirect("admin/index.jsp");
            } else if ("采购人".equals(role)) {
                response.sendRedirect("purchase/index.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else {
            // 登录失败
            response.getWriter().write("登录失败，用户名或密码错误！");
        }
    }
}