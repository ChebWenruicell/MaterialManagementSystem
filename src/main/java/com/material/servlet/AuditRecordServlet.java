package com.material.servlet;

import com.material.bean.AuditRecord;
import com.material.bean.SysUser;
import com.material.dao.AuditRecordDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

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

        // 新增：接收页面筛选参数
        String keyword = request.getParameter("keyword");
        String auditResult = request.getParameter("auditResult");
        String auditDate = request.getParameter("auditDate");

        // 替换原固定查询，调用带多条件过滤的Dao方法
        List<AuditRecord> recordList = recordDao.listByFilter(user.getUsername(), keyword, auditResult, auditDate);

        // 传递列表 + 回填筛选条件到页面
        request.setAttribute("recordList", recordList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("auditResult", auditResult);
        request.setAttribute("auditDate", auditDate);

        request.getRequestDispatcher("/approver/auditRecord.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}