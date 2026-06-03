<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/purchase/myList -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的采购申请</title>
</head>
<body>
    <%@ include file="../common/sidebar_purchaser.jsp" %>
    <div class="main-content">
        <h1 class="page-title">我的采购申请</h1>
        
        <div class="card">
            <table class="table">
                <thead>
                    <tr>
                        <th>采购单号</th>
                        <th>申请部门</th>
                        <th>物资名称</th>
                        <th>数量</th>
                        <th>状态</th>
                        <th>申请时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${purchaseList}" var="purchase">
                        <tr>
                            <td>${purchase.purchaseNo}</td>
                            <td>${purchase.dept}</td>
                            <td>${purchase.item}</td>
                            <td>${purchase.num}</td>
                            <td>
                                <span class="todo-status ${purchase.status == '已完成' ? 'status-success' : purchase.status == '已驳回' ? 'status-danger' : 'status-warning'}">
                                    ${purchase.status}
                                </span>
                            </td>
                            <td>${purchase.createTime}</td>
                            <td>
                                <c:if test="${purchase.status == '已通过'}">
                                    <a href="${pageContext.request.contextPath}/purchaser/uploadVoucher.jsp?purchaseId=${purchase.id}" class="btn btn-primary btn-sm">上传凭证</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty purchaseList}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">
                                暂无采购申请
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>