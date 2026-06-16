<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作日志</title>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">操作日志</h1>
        
        <div class="card">
            <div class="card-header d-flex align-items-center gap-3 flex-wrap">
                <h4 class="mb-0">全部操作日志</h4>
                <!-- 筛选表单：操作人 + 操作日期 -->
                <form action="${pageContext.request.contextPath}/log/list" method="get" class="form-inline">
                    <input type="text" class="form-control mr-2" name="keyword" placeholder="操作人账号" value="${keyword}">
                    <label class="mb-0 mr-1">选择日期：</label>
                    <input type="date" class="form-control mr-2" name="logDate" value="${logDate}">
                    <button class="btn btn-success" type="submit">筛选</button>
                    <a href="${pageContext.request.contextPath}/log/list" class="btn btn-outline-secondary ml-2">重置</a>
                </form>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>操作人</th>
                        <th>操作内容</th>
                        <th>操作时间</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${logList}" var="log">
                        <tr>
                            <td>${log.username}</td>
                            <td>${log.operate}</td>
                            <td>${log.createTime}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty logList}">
                        <tr>
                            <td colspan="3" class="text-center text-muted">暂无匹配日志数据</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>