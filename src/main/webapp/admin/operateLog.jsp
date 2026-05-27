<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/log/list -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <table class="table">
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
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>