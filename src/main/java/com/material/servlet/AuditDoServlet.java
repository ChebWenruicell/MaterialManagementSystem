package com.material.servlet;

import com.material.bean.AuditRecord;
import com.material.bean.SysUser;
import com.material.dao.AuditRecordDao;
import com.material.dao.PurchaseApplyDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/audit/do")
public class AuditDoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();
    private AuditRecordDao auditDao = new AuditRecordDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        SysUser loginUser = (SysUser) session.getAttribute("user");

        // 登录&角色校验
        if (loginUser == null || !"审批人".equals(loginUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 获取表单参数
        int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));
        String auditResult = request.getParameter("result");
        String auditReason = request.getParameter("reason");
        String auditorName = loginUser.getUsername();

        // 1、更新采购单状态
        String status = "已驳回";
        if ("通过".equals(auditResult)) {
            status = "已通过";
        }
        purchaseDao.updateStatus(purchaseId, status);

        // 2、组装审批记录并入库
        AuditRecord record = new AuditRecord();
        record.setPurchaseId(purchaseId);
        record.setAuditResult(auditResult);
        record.setAuditReason(auditReason);
        record.setAuditUser(auditorName);
        // 删掉 setAuditTime，数据库SQL自动NOW()填充时间
        auditDao.add(record);

        // 3、审批完成跳转工作台
        response.sendRedirect(request.getContextPath() + "/approver/index");
    }

    // 禁止GET直接访问
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/approver/index");
    }
}