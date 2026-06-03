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
            System.out.println("查询到的用户数量：" + list.size());
            
            request.setAttribute("list", list);
            request.getRequestDispatcher("/admin/userManage.jsp").forward(request, response);
        } 
        else if ("/add".equals(path)) {
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

            // ✅ 只保留这一行正确的日志（空判断已加）
            String opName = loginUser==null ? "系统" : loginUser.getUsername();
            new OperateLogDao().add(new OperateLog(opName,"新增用户："+username));
            
            response.sendRedirect("list");
        } 
        else if ("/delete".equals(path)) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            userDao.delete(id);
            
            // ✅ 修复空指针
            String opName = loginUser==null ? "系统" : loginUser.getUsername();
            new OperateLogDao().add(new OperateLog(opName, "删除用户ID：" + id));
            
            response.sendRedirect("list");
        }
        else if("/update".equals(path)){
            Integer id=Integer.parseInt(request.getParameter("id"));
            String un=request.getParameter("username");
            String rn=request.getParameter("realName");
            String ro=request.getParameter("role");
            String ph=request.getParameter("phone");
            String em=request.getParameter("email");
            SysUser su=new SysUser();
            su.setId(id);
            su.setUsername(un);
            su.setRealName(rn);
            su.setRole(ro);
            su.setPhone(ph);
            su.setEmail(em);
            userDao.update(su);

            // ✅ 新增修改日志（空判断）
            String opName = loginUser==null ? "系统" : loginUser.getUsername();
            new OperateLogDao().add(new OperateLog(opName, "修改用户ID：" + id));
            
            response.sendRedirect("list");
        }
    }
}