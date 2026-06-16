package com.material.servlet;

import com.material.bean.SysUser;
import com.material.dao.TodoDao;
import com.material.dao.NoticeDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/purchaser/index")
public class PurchaserIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TodoDao todoDao = new TodoDao();
    private NoticeDao noticeDao = new NoticeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 权限校验：未登录或角色不符直接跳登录页
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        if (user == null || !"采购人".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 查询当前角色的待办、公告数据，存入请求域
        request.setAttribute("todoList", todoDao.listByRole("采购人"));
        request.setAttribute("noticeList", noticeDao.listAll());

        // 转发到 JSP 页面渲染（JSP 依然在这里工作）
        request.getRequestDispatcher("/purchaser/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}