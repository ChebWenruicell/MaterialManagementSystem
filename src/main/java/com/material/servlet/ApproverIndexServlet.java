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

@WebServlet("/approver/index")
public class ApproverIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TodoDao todoDao = new TodoDao();
    private NoticeDao noticeDao = new NoticeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        if (user == null || !"审批人".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setAttribute("todoList", todoDao.listByRole("审批人"));
        request.setAttribute("noticeList", noticeDao.listAll());
        request.getRequestDispatcher("/approver/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}