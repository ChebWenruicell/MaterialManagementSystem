<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
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
            <!-- 筛选栏 -->
            <div class="card-header d-flex align-items-center gap-3 flex-wrap">
                <h4 class="mb-0">待审核列表</h4>
                <form action="${pageContext.request.contextPath}/approver/auditList" method="get" class="form-inline">
                    <input type="text" class="form-control mr-2" name="keyword" placeholder="采购单号/物资名称" value="${keyword}">
                    <button class="btn btn-success" type="submit">筛选</button>
                    <a href="${pageContext.request.contextPath}/approver/auditList" class="btn btn-outline-secondary ml-2">重置</a>
                </form>
            </div>
            <table class="table table-striped table-hover">
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