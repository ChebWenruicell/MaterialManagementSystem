package com.material.servlet;

import com.material.bean.PurchaseApply;
import com.material.bean.SysUser;
import com.material.dao.PurchaseApplyDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/approver/auditDetail")
public class AuditDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        if(user == null || !"审批人".equals(user.getRole())){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int pid = Integer.parseInt(request.getParameter("purchaseId"));
        PurchaseApply apply = purchaseDao.getById(pid);
        request.setAttribute("apply", apply);
        request.getRequestDispatcher("/approver/auditDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}