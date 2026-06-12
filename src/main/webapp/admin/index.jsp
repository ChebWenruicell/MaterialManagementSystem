<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        .manage-btn {
            float: right;
            font-size: 14px;
            padding: 4px 12px;
        }
    </style>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">管理员工作台</h1>
        
        <!-- 数据统计区（已修正采购记录跳转路径） -->
        <div class="row">
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/user/list'">
                    <div class="stat-icon stat-icon-purple">👥</div>
                    <div class="stat-number">${userCount}</div>
                    <div class="stat-label">系统用户总数</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/template/list'">
                    <div class="stat-icon stat-icon-blue">☰</div>
                    <div class="stat-number">${materialCount}</div>
                    <div class="stat-label">采购模板配置</div>
                </div>
            </div>
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/material/list'">
                    <div class="stat-icon stat-icon-brown">📦</div>
                    <div class="stat-number">${purchaseCount}</div>
                    <div class="stat-label">物资管理</div>
                </div>
            </div>
            <!-- ✅ 修正为你实际的采购记录地址 -->
            <div class="col-3">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/purchase/listAll'">
                    <div class="stat-icon stat-icon-green">📊</div>
                    <div class="stat-number">${completedCount}</div>
                    <div class="stat-label">采购记录</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- 待办事项（动态加载+管理入口） -->
            <div class="col-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">待办事项</h3>
                        <a href="${pageContext.request.contextPath}/admin/todo" class="btn btn-sm btn-primary manage-btn">管理</a>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${todoList}" var="todo">
                            <div class="todo-item">
                                <span>${todo.content}</span>
                                <span class="${todo.status == '已完成' ? 'status-success' : 'status-warning'}">${todo.status}</span>
                            </div>
                        </c:forEach>
                        <c:if test="${empty todoList}">
                            <div class="text-center text-muted" style="padding: 24px;">
                                🎉 暂无待办事项
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- 系统公告（动态加载+管理入口） -->
            <div class="col-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">系统公告</h3>
                        <a href="${pageContext.request.contextPath}/admin/notice" class="btn btn-sm btn-primary manage-btn">管理</a>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${noticeList}" var="notice">
                            <div class="todo-item">
                                <span>${notice.title}</span>
                                <span class="${notice.status == '已发布' ? 'status-success' : 'status-warning'}">${notice.status}</span>
                            </div>
                        </c:forEach>
                        <c:if test="${empty noticeList}">
                            <div class="text-center text-muted" style="padding: 24px;">
                                📢 暂无系统公告
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>