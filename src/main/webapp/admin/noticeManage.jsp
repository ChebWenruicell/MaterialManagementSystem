<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>系统公告管理</title>
</head>
<body>
<%@ include file="../common/sidebar_admin.jsp" %>

<div class="main-content">
    <h2 class="page-title">系统公告管理</h2>

    <!-- 发布公告卡片 -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">发布新公告</h3>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/notice" method="post">
                <div class="form-group">
                    <label class="form-label">公告标题</label>
                    <input type="text" name="title" class="form-input" placeholder="请输入公告标题" required>
                </div>
                <div class="form-group">
                    <label class="form-label">公告内容</label>
                    <textarea name="content" class="form-input form-textarea" placeholder="请输入公告内容" required></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">公告状态</label>
                    <select name="status" class="form-input">
                        <option value="已发布">已发布</option>
                        <option value="进行中">进行中</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">发布公告</button>
            </form>
        </div>
    </div>

    <!-- 公告列表卡片 -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">公告列表</h3>
        </div>
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>公告标题</th>
                        <th>公告内容</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${noticeList}" var="notice">
                        <tr>
                            <td>${notice.title}</td>
                            <td>${notice.content}</td>
                            <td>
                                <c:if test="${notice.status == '已发布'}">
                                    <span class="todo-status status-success">已发布</span>
                                </c:if>
                                <c:if test="${notice.status == '进行中'}">
                                    <span class="todo-status status-warning">进行中</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/notice/delete?id=${notice.id}" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('确定删除该公告？')">删除</a>
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