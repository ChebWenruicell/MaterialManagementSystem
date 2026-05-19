<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <ul class="sidebar-menu">
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/approver/index.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/approver/index.jsp">
                <span class="icon">⌂</span>
                <span>工作台</span>
            </a>
        </li>
        <!-- 后期改回：/audit/list -->
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/approver/auditList.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/approver/auditList.jsp">
                <span class="icon">✓</span>
                <span>待审核采购单</span>
            </a>
        </li>
        <!-- 后期改回：/audit/record -->
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/approver/auditRecord.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/approver/auditRecord.jsp">
                <span class="icon">☰</span>
                <span>我的审批记录</span>
            </a>
        </li>
    </ul>
</div>