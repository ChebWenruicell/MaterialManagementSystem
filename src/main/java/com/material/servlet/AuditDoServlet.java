package com.material.servlet;

import com.material.bean.AuditRecord;
import com.material.bean.PurchaseApply;
import com.material.bean.SysUser;
import com.material.bean.OperateLog;
import com.material.dao.AuditRecordDao;
import com.material.dao.PurchaseApplyDao;
import com.material.dao.OperateLogDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet("/audit/do")
public class AuditDoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();
    private AuditRecordDao auditDao = new AuditRecordDao();
    private OperateLogDao logDao = new OperateLogDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        SysUser loginUser = (SysUser) session.getAttribute("user");

        // 修复角色判断：数据库角色是英文approver
        if (loginUser == null || !"approver".equals(loginUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 获取表单参数
        int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));
        String auditResult = request.getParameter("result");
        String auditReason = request.getParameter("reason");
        String auditorName = loginUser.getUsername();

        // 提前查采购单拿单号
        PurchaseApply apply = purchaseDao.getById(purchaseId);
        String purchaseNo = apply.getPurchaseNo();

        // 判断通过/驳回
        String status = "已驳回";
        String operateText = "驳回采购单";
        if ("通过".equals(auditResult)) {
            status = "已通过";
            operateText = "通过采购单";
        }
        purchaseDao.updateStatus(purchaseId, status);

        // 保存审批记录
        AuditRecord record = new AuditRecord();
        record.setPurchaseId(purchaseId);
        record.setAuditResult(auditResult);
        record.setAuditReason(auditReason);
        record.setAuditUser(auditorName);
        auditDao.add(record);

        // ========== 适配你OperateLog实体的字段名 ==========
        OperateLog log = new OperateLog();
        log.setUsername(auditorName);
        log.setOperate(operateText + purchaseNo);
        log.setCreateTime(new Date());
        logDao.add(log);

        // 跳转工作台
        response.sendRedirect(request.getContextPath() + "/approver/index");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/approver/index");
    }
}