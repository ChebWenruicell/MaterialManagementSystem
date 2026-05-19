<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/user/list -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">用户管理</h1>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">用户列表</h3>
                <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">添加用户</button>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>账号</th>
                        <th>姓名</th>
                        <th>角色</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userList}" var="user">
                        <tr>
                            <td>${user.username}</td>
                            <td>${user.realName}</td>
                            <td>${user.role}</td>
                            <td>${user.phone}</td>
                            <td>${user.email}</td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="deleteUser(${user.id})">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- 添加用户模态框 -->
        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">添加用户</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/userManage.jsp" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">账号</label>
                                <input type="text" name="account" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">密码</label>
                                <input type="password" name="password" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">姓名</label>
                                <input type="text" name="name" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">角色</label>
                                <select name="role" class="form-input" required>
                                    <option value="采购人">采购人</option>
                                    <option value="审批人">审批人</option>
                                    <option value="admin">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">电话</label>
                                <input type="text" name="phone" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">邮箱</label>
                                <input type="email" name="email" class="form-input">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    
    <script>
        function deleteUser(id) {
            if (confirm("确定要删除该用户吗？")) {
                // 后期对接Servlet：/user/delete
                alert('删除成功');
                location.reload();
            }
        }
    </script>
</body>
</html>