<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
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
        <!-- 筛选栏 -->
        <div class="card-header d-flex flex-wrap align-items-center gap-3">
            <h4 class="mb-0">审批记录列表</h4>
            <form action="${pageContext.request.contextPath}/approver/auditRecord" method="get" class="form-inline">
                <input type="text" class="form-control mr-2" name="keyword" placeholder="采购单号" value="${keyword}">
                <select name="auditResult" class="form-control mr-2">
                    <option value="">全部结果</option>
                    <option value="通过" ${auditResult=='通过'?'selected':''}>通过</option>
                    <option value="驳回" ${auditResult=='驳回'?'selected':''}>驳回</option>
                </select>
                <label class="mb-0 mr-1">审批日期：</label>
                <input type="date" class="form-control mr-2" name="auditDate" value="${auditDate}">
                <button class="btn btn-success" type="submit">筛选</button>
                <a href="${pageContext.request.contextPath}/approver/auditRecord" class="btn btn-outline-secondary ml-2">重置</a>
            </form>
        </div>
        <table class="table table-striped table-hover">
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