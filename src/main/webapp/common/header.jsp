<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="style.jsp" %>
<%
    // 权限控制：未登录跳转到登录页
    //if (session.getAttribute("loginUser") == null) {
     //   response.sendRedirect(request.getContextPath() + "/login.jsp");
     //   return;
   // }
%>
<div class="header">
    <div class="header-left">
        <div class="header-logo">物资采购管理系统</div>
    </div>
    <div class="header-right">
        <div class="user-info">
            <div class="user-avatar">${sessionScope.loginUser.realName.substring(0,1)}</div>
            <span>${sessionScope.loginUser.realName}</span>
            <span>(${sessionScope.loginUser.role == 'admin' ? '系统管理员' : sessionScope.loginUser.role})</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
    </div>
</div>