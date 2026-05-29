
package com.material.servlet;
import java.io.IOException;
import java.util.List;

import com.material.bean.OperateLog;
import com.material.bean.SysUser;
import com.material.dao.OperateLogDao;
import com.material.dao.SysUserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SysUserDao userDao = new SysUserDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        SysUser loginUser = (SysUser) session.getAttribute("user");
        if ("/list".equals(path)) {
            List<SysUser> list = userDao.list();
            request.setAttribute("list", list);
            request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
        } else if ("/add".equals(path)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String realName = request.getParameter("realName");
            String role = request.getParameter("role");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String md5Pwd = "e10adc3949ba59abbe56e057f20f883e";
            SysUser u = new SysUser();
            u.setUsername(username);
            u.setPassword("123456".equals(password) ? md5Pwd : password);
            u.setRealName(realName);
            u.setRole(role);
            u.setPhone(phone);
            u.setEmail(email);
            userDao.add(u);
            new OperateLogDao().add(new OperateLog(loginUser.getUsername(), "新增用户：" + username));
            response.sendRedirect("list");
        } else if ("/delete".equals(path)) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            userDao.delete(id);
            new OperateLogDao().add(new OperateLog(loginUser.getUsername(), "删除用户ID：" + id));
            response.sendRedirect("list");
        }
    }
}