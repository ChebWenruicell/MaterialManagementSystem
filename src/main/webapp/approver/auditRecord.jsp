<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/audit/record -->
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
                    <c:forEach items="${recordList}" var="record">
                        <tr>
                            <td>${record.purchaseNo}</td>
                            <td>
                                <span class="todo-status ${record.auditResult == '通过' ? 'status-success' : 'status-danger'}">
                                    ${record.auditResult}
                                </span>
                            </td>
                            <td>${record.auditReason}</td>
                            <td>${record.auditTime}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>