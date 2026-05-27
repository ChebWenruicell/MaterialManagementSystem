<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/export/purchase -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购记录</title>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">采购记录</h1>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">全部采购记录</h3>
                <a href="${pageContext.request.contextPath}/admin/purchaseRecord.jsp" class="btn btn-primary">导出Excel</a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>采购单号</th>
                        <th>申请部门</th>
                        <th>物资名称</th>
                        <th>数量</th>
                        <th>申请人</th>
                        <th>状态</th>
                        <th>申请时间</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${purchaseList}" var="purchase">
                        <tr>
                            <td>${purchase.purchaseNo}</td>
                            <td>${purchase.dept}</td>
                            <td>${purchase.item}</td>
                            <td>${purchase.num}</td>
                            <td>${purchase.applyUser}</td>
                            <td>
                                <span class="todo-status ${purchase.status == '已完成' ? 'status-success' : purchase.status == '已驳回' ? 'status-danger' : 'status-warning'}">
                                    ${purchase.status}
                                </span>
                            </td>
                            <td>${purchase.createTime}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>