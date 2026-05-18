<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/style.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资采购管理系统 - 登录</title>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <h2 class="login-title">物资采购管理系统</h2>
            <% if (request.getAttribute("errorMsg") != null) { %>
                <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label class="form-label">用户名</label>
                    <input type="text" name="username" class="form-input" placeholder="请输入用户名" required>
                </div>
                <div class="form-group">
                    <label class="form-label">密码</label>
                    <input type="password" name="password" class="form-input" placeholder="请输入密码" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; height: 44px; font-size: 16px;">登录</button>
            </form>
        </div>
    </div>
</body>
</html>