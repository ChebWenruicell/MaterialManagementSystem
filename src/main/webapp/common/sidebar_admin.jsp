<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <ul class="sidebar-menu">
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/admin/index.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/index.jsp">
                <span class="icon">🏠</span>
                <span>工作台</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/admin/userManage.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/userManage.jsp">
                <span class="icon">👥</span>
                <span>用户管理</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/admin/templateConfig.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/templateConfig.jsp">
                <span class="icon">📋</span>
                <span>采购模板配置</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/admin/materialManage.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/materialManage.jsp">
                <span class="icon">📦</span>
                <span>物资管理</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/admin/purchaseRecord.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/purchaseRecord.jsp">
                <span class="icon">📊</span>
                <span>采购记录</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/admin/operateLog.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/admin/operateLog.jsp">
                <span class="icon">📝</span>
                <span>操作日志</span>
            </a>
        </li>
    </ul>
</div>