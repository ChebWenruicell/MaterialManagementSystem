<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>待办事项管理</title>
    <!-- 沿用你原有全局样式，不额外写新样式 -->
</head>
<body>
<%@ include file="../common/sidebar_admin.jsp" %>

<div class="main-content">
    <h2 class="page-title">待办事项管理</h2>

    <!-- 新增待办卡片 -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">新增待办事项</h3>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/todo" method="post">
                <div class="form-group">
                    <label class="form-label">待办内容</label>
                    <input type="text" name="content" class="form-input" placeholder="请输入待办内容" required>
                </div>
                <div class="form-group">
                    <label class="form-label">可见角色</label>
                    <select name="role" class="form-input">
                        <option value="admin" selected>仅管理员</option>
                        <option value="all">全部角色</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">提交添加</button>
            </form>
        </div>
    </div>

    <!-- 待办列表卡片 -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">待办列表</h3>
        </div>
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>待办内容</th>
                        <th>可见角色</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${todoList}" var="todo">
                        <tr>
                            <td>${todo.content}</td>
                            <td>${todo.role}</td>
                            <td>
                                <c:if test="${todo.status == '待处理'}">
                                    <span class="todo-status status-warning">待处理</span>
                                </c:if>
                                <c:if test="${todo.status == '已完成'}">
                                    <span class="todo-status status-success">已完成</span>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${todo.status == '待处理'}">
                                    <a href="${pageContext.request.contextPath}/admin/todo/complete?id=${todo.id}" 
                                       class="btn btn-outline btn-sm">标记完成</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/admin/todo/delete?id=${todo.id}" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('确定删除该条待办？')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>