<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员工作台</title>
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
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">管理员工作台</h1>
        
        <!-- 快捷操作区 -->
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/admin/userManage.jsp" class="quick-action-btn">
                <div class="quick-action-icon">👥</div>
                <span>用户管理</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/templateConfig.jsp" class="quick-action-btn">
                <div class="quick-action-icon">☷</div>
                <span>模板配置</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/materialManage.jsp" class="quick-action-btn">
                <div class="quick-action-icon">📦</div>
                <span>物资管理</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/purchaseRecord.jsp" class="quick-action-btn">
                <div class="quick-action-icon">📊</div>
                <span>采购记录</span>
            </a>
        </div>
        
        <!-- 数据统计区（现在可点击跳转） -->
        <div class="row">
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/admin/userManage.jsp'">
                    <div class="stat-icon stat-icon-blue">👥</div>
                    <div class="stat-number">${userCount}</div>
                    <div class="stat-label">系统用户总数</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/admin/materialManage.jsp'">
                    <div class="stat-icon stat-icon-green">📦</div>
                    <div class="stat-number">${materialCount}</div>
                    <div class="stat-label">物资种类数量</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/admin/purchaseRecord.jsp'">
                    <div class="stat-icon stat-icon-orange">📊</div>
                    <div class="stat-number">${purchaseCount}</div>
                    <div class="stat-label">采购单总数</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/admin/purchaseRecord.jsp'">
                    <div class="stat-icon stat-icon-green">✅</div>
                    <div class="stat-number">${completedCount}</div>
                    <div class="stat-label">已完成采购单</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- 待办事项 -->
            <div class="col-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">待办事项</h3>
                    </div>
                    <div class="card-body">
                        <div class="todo-item">
                            <span>待维护物资信息：${materialCount}项</span>
                            <span class="status-warning">待处理</span>
                        </div>
                        <div class="todo-item">
                            <span>系统用户管理</span>
                            <span class="status-warning">待处理</span>
                        </div>
                        <div class="todo-item">
                            <span>采购模板更新</span>
                            <span class="status-warning">待处理</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 系统公告 -->
            <div class="col-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">系统公告</h3>
                    </div>
                    <div class="card-body">
                        <div class="todo-item">
                            <span>系统已升级至V2.0版本，新增AI生成采购单功能</span>
                            <span class="status-success">已发布</span>
                        </div>
                        <div class="todo-item">
                            <span>请各部门于本月底前完成物资盘点</span>
                            <span class="status-warning">进行中</span>
                        </div>
                        <div class="todo-item">
                            <span>系统将于每周日凌晨2点进行维护</span>
                            <span class="status-success">已发布</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>