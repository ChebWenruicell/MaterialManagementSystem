<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员工作台</title>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">管理员工作台</h1>
        
        <div class="row">
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-number">3</div>
                    <div class="stat-label">系统用户</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-number">5</div>
                    <div class="stat-label">物资种类</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-number">12</div>
                    <div class="stat-label">采购单总数</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card">
                    <div class="stat-number">2</div>
                    <div class="stat-label">待审核采购单</div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h3 class="card-title">待办事项</h3>
            </div>
            <div class="card-body">
                <div class="todo-item">
                    <span>待维护物资信息：5项</span>
                    <span class="status-warning">待处理</span>
                </div>
                <div class="todo-item">
                    <span>待审核采购单：2个</span>
                    <span class="status-warning">待处理</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>