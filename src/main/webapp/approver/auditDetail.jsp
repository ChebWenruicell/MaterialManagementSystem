<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/approver/auditDetail -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购单审核</title>
</head>
<body>
    <%@ include file="../common/sidebar_approver.jsp" %>
    <div class="main-content">
        <h1 class="page-title">采购单审核</h1>
        
        <div class="card">
            <div class="form-group">
                <label class="form-label">采购单号</label>
                <input type="text" class="form-input" value="${apply.purchaseNo}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">申请人</label>
                <input type="text" class="form-input" value="${apply.applyUser}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">申请部门</label>
                <input type="text" class="form-input" value="${apply.dept}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">物资名称</label>
                <input type="text" class="form-input" value="${apply.item}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">规格型号</label>
                <input type="text" class="form-input" value="${apply.spec}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">数量</label>
                <input type="number" class="form-input" value="${apply.num}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">用途</label>
                <textarea class="form-input form-textarea" readonly>${apply.usageDesc}</textarea>
            </div>
            
            <div class="form-group">
                <label class="form-label">附件</label>
                <c:if test="${not empty apply.filePath}">
                    <a href="${pageContext.request.contextPath}/${apply.filePath}" target="_blank">查看附件</a>
                </c:if>
                <c:if test="${empty apply.filePath}">
                    <span class="text-muted">无附件</span>
                </c:if>
            </div>
            
            <!-- 表单提交地址改为审核处理Servlet，这里后续你再写AuditServlet，先统一规范 -->
            <form action="${pageContext.request.contextPath}/audit/do" method="post">
                <input type="hidden" name="purchaseId" value="${apply.id}">
                <div class="form-group">
                    <label class="form-label">审批意见</label>
                    <textarea name="reason" class="form-input form-textarea" required></textarea>
                </div>
                <button type="submit" name="result" value="通过" class="btn btn-primary">通过</button>
                <button type="submit" name="result" value="驳回" class="btn btn-danger" style="margin-left: 16px;">驳回</button>
            </form>
        </div>
    </div>
</body>
</html>