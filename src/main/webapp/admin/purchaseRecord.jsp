<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购记录</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">采购记录</h1>
        
        <div class="card">
            <div class="card-header d-flex flex-wrap align-items-center justify-content-between gap-3">
                <h3 class="card-title mb-0">全部采购记录</h3>
                <!-- 筛选表单 -->
                <form action="${pageContext.request.contextPath}/purchase/listAll" method="get" class="form-inline">
                    <input class="form-control mr-2" type="text" name="keyword" placeholder="采购单号/物资名称" value="${keyword}">
                    <select name="status" class="form-control mr-2">
                        <option value="">全部状态</option>
                        <option value="待审核" ${status=='待审核'?'selected':''}>待审核</option>
                        <option value="已通过" ${status=='已通过'?'selected':''}>已通过</option>
                        <option value="已驳回" ${status=='已驳回'?'selected':''}>已驳回</option>
                    </select>
                    <button class="btn btn-success mr-2" type="submit">筛选</button>
                    <a href="${pageContext.request.contextPath}/purchase/listAll" class="btn btn-outline-secondary">重置</a>
                </form>
                <a href="${pageContext.request.contextPath}/export/purchase" class="btn btn-primary">导出Excel</a>
            </div>
            <table class="table table-striped table-hover">
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
                                <span class="todo-status ${purchase.status == '已通过' ? 'status-success' : purchase.status == '已驳回' ? 'status-danger' : 'status-warning'}">
                                    ${purchase.status}
                                </span>
                            </td>
                            <td>${purchase.createTime}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty purchaseList}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">暂无匹配的采购记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>