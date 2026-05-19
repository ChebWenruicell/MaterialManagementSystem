<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购人工作台</title>
    <style>
      
        .stat-card {
            cursor: pointer;
            transition: all 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }
    </style>
</head>
<body>
    <%@ include file="../common/sidebar_purchaser.jsp" %>
    <div class="main-content">
        <h1 class="page-title">采购人工作台</h1>
        
        <!-- 快捷操作区 -->
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/purchaser/purchaseApply.jsp" class="quick-action-btn">
                <div class="quick-action-icon">✎</div>
                <span>提交采购申请</span>
            </a>
            <a href="${pageContext.request.contextPath}/purchaser/aiGenerate.jsp" class="quick-action-btn">
                <div class="quick-action-icon">⚙</div>
                <span>AI生成采购单</span>
            </a>
            <a href="${pageContext.request.contextPath}/purchaser/myPurchase.jsp" class="quick-action-btn">
                <div class="quick-action-icon">☰</div>
                <span>我的申请</span>
            </a>
            <a href="${pageContext.request.contextPath}/purchaser/uploadVoucher.jsp" class="quick-action-btn">
                <div class="quick-action-icon">📎</div>
                <span>上传凭证</span>
            </a>
        </div>
        
        <!-- 数据统计区（现在可点击跳转） -->
        <div class="row">
            <div class="col-4">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/purchaser/myPurchase.jsp'">
                    <div class="stat-icon stat-icon-blue">☰</div>
                    <div class="stat-number">${myPurchaseCount}</div>
                    <div class="stat-label">我的采购单</div>
                </div>
            </div>
            <div class="col-4">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/purchaser/myPurchase.jsp'">
                    <div class="stat-icon stat-icon-orange">⏳</div>
                    <div class="stat-number">${pendingCount}</div>
                    <div class="stat-label">待审核</div>
                </div>
            </div>
            <div class="col-4">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/purchaser/myPurchase.jsp'">
                    <div class="stat-icon stat-icon-green">✅</div>
                    <div class="stat-number">${completedCount}</div>
                    <div class="stat-label">已完成</div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">待办事项</h3>
            </div>
            <div class="card-body">
                <c:forEach items="${todoList}" var="todo">
                    <div class="todo-item">
                        <span>${todo.content}</span>
                        <span class="status-warning">待处理</span>
                    </div>
                </c:forEach>
                <c:if test="${empty todoList}">
                    <div class="text-center text-muted" style="padding: 24px;">
                        🎉 暂无待办事项，您可以提交新的采购申请
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>