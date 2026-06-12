<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentPage = (String) request.getAttribute("javax.servlet.forward.servlet_path");
    if (currentPage == null) {
        currentPage = request.getServletPath();
    }
    pageContext.setAttribute("currentPage", currentPage);
%>

<div class="sidebar">
    <ul class="sidebar-menu">
        <li class="sidebar-menu-item ${currentPage == '/admin/index' ? 'active' : ''}">
    <a href="${pageContext.request.contextPath}/admin/index">
        <span class="icon">⌂</span>
        <span>工作台</span>
    </a>
</li>

        <li class="sidebar-menu-item ${currentPage == '/admin/userManage.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/user/list">
                <span class="icon">👥</span>
                <span>用户管理</span>
            </a>
        </li>

        <!-- ✅ 只改这里：让采购模板走 Servlet 查数据库 -->
        <li class="sidebar-menu-item ${currentPage == '/admin/templateConfig.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/template/list">
                <span class="icon">☷</span>
                <span>采购模板配置</span>
            </a>
        </li>

        <li class="sidebar-menu-item ${currentPage == '/admin/materialManage.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/material/list">
                <span class="icon">📦</span>
                <span>物资管理</span>
            </a>
        </li>

       <li class="sidebar-menu-item ${currentPage == '/purchase/listAll' ? 'active' : ''}">
    <a href="${pageContext.request.contextPath}/purchase/listAll">
        <span class="icon">📊</span>
        <span>采购记录</span>
    </a>
</li>

        <li class="sidebar-menu-item ${currentPage == '/log/list' ? 'active' : ''}">
    <a href="${pageContext.request.contextPath}/log/list">
        <span class="icon">📝</span>
        <span>操作日志</span>
    </a>
</li>
    </ul>
</div>