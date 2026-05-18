<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="style.jsp" %>
<%
    // 临时关闭登录验证（仅用于查看界面）
    // if (session.getAttribute("loginUser") == null) {
    //     response.sendRedirect(request.getContextPath() + "/login.jsp");
    //     return;
    // }
%>
<div class="header">
    <div class="header-left">
        <div class="header-logo">物资采购管理系统</div>
    </div>
    <div class="header-right">
        <div class="user-info">
            <div class="user-avatar">测</div>
            <span>测试用户</span>
            <span>(管理员)</span>
        </div>
        <a href="${pageContext.request.contextPath}/login.jsp" class="logout-btn">退出登录</a>
    </div>
</div>