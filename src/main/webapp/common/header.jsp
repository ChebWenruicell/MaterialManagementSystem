<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.material.bean.SysUser" %>
<%@ include file="style.jsp" %>
<%
    // 从session取 user，和登录Servlet一致
    SysUser loginUser = (SysUser) session.getAttribute("user");
    String realName = "";
    String roleText = "";
    String avatarChar = "用";
    if(loginUser != null){
        realName = loginUser.getRealName();
        String role = loginUser.getRole();
        if("admin".equals(role)){
            roleText = "系统管理员";
        }else if("approver".equals(role)){
            roleText = "审批人";
        }else if("purchaser".equals(role)){
            roleText = "采购人";
        }else{
            roleText = role;
        }
        if(realName != null && realName.length() > 0){
            avatarChar = realName.substring(0,1);
        }
    }
%>
<div class="header">
    <div class="header-left">
        <div class="header-logo">物资采购管理系统</div>
    </div>
    <div class="header-right">
        <div class="user-info">
            <div class="user-avatar"><%=avatarChar%></div>
            <% if(loginUser != null){ %>
                <span><%=realName%></span>
                <span>(<%=roleText%>)</span>
            <% } %>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
    </div>
</div>