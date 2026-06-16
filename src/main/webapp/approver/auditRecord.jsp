<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的审批记录</title>
</head>
<body>
<%@ include file="../common/sidebar_approver.jsp" %>
<div class="main-content">
    <h1 class="page-title">我的审批记录</h1>
    <div class="card">
        <table class="table">
            <thead>
                <tr>
                    <th>采购单号</th>
                    <th>审批结果</th>
                    <th>审批意见</th>
                    <th>审批时间</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${recordList}" var="r">
                    <tr>
                        <td>${r.purchaseNo}</td>
                        <td>${r.auditResult}</td>
                        <td>${r.auditReason}</td>
                        <td>${r.auditTime}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty recordList}">
                    <tr>
                        <td colspan="4" class="text-center text-muted">暂无审批记录</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>