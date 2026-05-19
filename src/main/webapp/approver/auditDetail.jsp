<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/audit/do -->
<%@ include file="../common/header.jsp" %>
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
                <input type="text" class="form-input" value="${purchase.purchaseNo}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">申请人</label>
                <input type="text" class="form-input" value="${purchase.applyUser}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">申请部门</label>
                <input type="text" class="form-input" value="${purchase.dept}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">物资名称</label>
                <input type="text" class="form-input" value="${purchase.item}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">规格型号</label>
                <input type="text" class="form-input" value="${purchase.spec}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">数量</label>
                <input type="number" class="form-input" value="${purchase.num}" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">用途</label>
                <textarea class="form-input form-textarea" readonly>${purchase.usage}</textarea>
            </div>
            
            <div class="form-group">
                <label class="form-label">附件</label>
                <c:if test="${not empty purchase.filePath}">
                    <a href="${pageContext.request.contextPath}/${purchase.filePath}" target="_blank">查看附件</a>
                </c:if>
                <c:if test="${empty purchase.filePath}">
                    <span class="text-muted">无附件</span>
                </c:if>
            </div>
            
            <form action="${pageContext.request.contextPath}/approver/auditDetail.jsp" method="post">
                <input type="hidden" name="purchaseId" value="${purchase.id}">
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