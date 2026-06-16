<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 和管理员侧边栏逻辑一致：优先取原始请求路径，转发后也能正确识别
    String currentPage = (String) request.getAttribute("javax.servlet.forward.servlet_path");
    if (currentPage == null) {
        currentPage = request.getServletPath();
    }
    pageContext.setAttribute("currentPage", currentPage);
%>

<div class="sidebar">
    <ul class="sidebar-menu">
        <!-- 工作台：已改为走Servlet，地址栏无后缀，自动加载数据 -->
        <li class="sidebar-menu-item ${currentPage == '/approver/index' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/approver/index">
                <span class="icon">⌂</span>
                <span>工作台</span>
            </a>
        </li>

        <!-- 待审核采购单：暂保留JSP路径，补完Servlet后替换为 /approver/auditList -->
        <li class="sidebar-menu-item ${currentPage == '/approver/auditList.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/approver/auditList.jsp">
                <span class="icon">✓</span>
                <span>待审核采购单</span>
            </a>
        </li>

        <!-- 我的审批记录：暂保留JSP路径，补完Servlet后替换为 /approver/auditRecord -->
        <li class="sidebar-menu-item ${currentPage == '/approver/auditRecord.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/approver/auditRecord.jsp">
                <span class="icon">☰</span>
                <span>我的审批记录</span>
            </a>
        </li>
    </ul>
</div>