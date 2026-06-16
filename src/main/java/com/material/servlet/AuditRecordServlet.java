package com.material.servlet;

import com.material.bean.SysUser;
import com.material.dao.AuditRecordDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/approver/auditRecord")
public class AuditRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AuditRecordDao recordDao = new AuditRecordDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 权限校验：仅审批人可访问
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        if (user == null || !"审批人".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 查询当前登录审批人的所有审批记录
        request.setAttribute("recordList", recordDao.listByApprover(user.getUsername()));

        // 内部转发到 JSP 渲染，地址栏不显示 .jsp 后缀
        request.getRequestDispatcher("/approver/auditRecord.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}