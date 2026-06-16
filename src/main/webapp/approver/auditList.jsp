<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>待审核采购单</title>
</head>
<body>
    <%@ include file="../common/sidebar_approver.jsp" %>
    <div class="main-content">
        <h1 class="page-title">待审核采购单</h1>
        <div class="card">
            <table class="table">
                <thead>
                    <tr>
                        <th>采购单号</th>
                        <th>申请部门</th>
                        <th>申请人</th>
                        <th>申请时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pendingList}" var="purchase">
                        <tr>
                            <td>${purchase.purchaseNo}</td>
                            <td>${purchase.dept}</td>
                            <td>${purchase.applyUser}</td>
                            <td>${purchase.createTime}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/approver/auditDetail?purchaseId=${purchase.id}" class="btn btn-primary btn-sm">审核</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingList}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">
                                🎉 暂无待审核采购单
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>