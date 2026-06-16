<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <ul class="sidebar-menu">
        <!-- 工作台：走Servlet /purchaser/index -->
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/purchaser/index.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/purchaser/index">
                <span class="icon">⌂</span>
                <span>工作台</span>
            </a>
        </li>
        <!-- 提交采购申请：访问Servlet，去掉.jsp -->
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/purchaser/purchaseApply.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/purchaser/purchaseApply">
                <span class="icon">✎</span>
                <span>提交采购申请</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/purchaser/aiGenerate.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/purchaser/aiGenerate.jsp">
                <span class="icon">⚙</span>
                <span>AI生成采购单</span>
            </a>
        </li>
        <!-- 我的采购申请 后续如果做Servlet再替换，当前保持jsp不变 -->
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/purchaser/myPurchase.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/purchaser/myPurchase.jsp">
                <span class="icon">☰</span>
                <span>我的采购申请</span>
            </a>
        </li>
        <li class="sidebar-menu-item ${pageContext.request.servletPath == '/purchaser/uploadVoucher.jsp' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/purchaser/uploadVoucher.jsp">
                <span class="icon">📎</span>
                <span>上传凭证</span>
            </a>
        </li>
    </ul>
</div>