<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
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
            <div class="card-header d-flex flex-wrap align-items-center justify-content-between gap-3">
                <h3 class="card-title mb-0">用户列表</h3>
                <!-- 筛选表单 -->
                <form action="${pageContext.request.contextPath}/user/list" method="get" class="form-inline">
                    <input type="text" class="form-control mr-2" name="keyword" placeholder="账号/姓名搜索" value="${keyword}">
                    <select name="role" class="form-control mr-2">
                        <option value="">全部角色</option>
                        <option value="admin" ${role=='admin'?'selected':''}>管理员</option>
                        <option value="采购人" ${role=='采购人'?'selected':''}>采购人</option>
                        <option value="审批人" ${role=='审批人'?'selected':''}>审批人</option>
                    </select>
                    <button class="btn btn-success mr-2" type="submit">筛选</button>
                    <a href="${pageContext.request.contextPath}/user/list" class="btn btn-outline-secondary">重置</a>
                </form>
                <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">添加用户</button>
            </div>

            <div style="padding:10px; background:#f8f9fa;">
                检测到用户数量：${list.size()}
            </div>

            <table class="table table-striped table-hover">
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
                    <c:forEach items="${list}" var="user">
                        <tr>
                            <td>${user.username}</td>
                            <td>${user.realName}</td>
                            <td>${user.role}</td>
                            <td>${user.phone}</td>
                            <td>${user.email}</td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="deleteUser(${user.id})">删除</button>
                                <button class="btn btn-info btn-sm ml-1" data-toggle="modal" data-target="#editModal"
                                onclick="fillData(${user.id},'${user.username}','${user.realName}','${user.role}','${user.phone}','${user.email}')">修改</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">暂无匹配用户数据</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <!-- 新增弹窗 -->
        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">添加用户</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/user/add" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">账号</label>
                                <input type="text" name="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">密码</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">姓名</label>
                                <input type="text" name="realName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">角色</label>
                                <select name="role" class="form-control" required>
                                    <option value="采购人">采购人</option>
                                    <option value="审批人">审批人</option>
                                    <option value="admin">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">电话</label>
                                <input type="text" name="phone" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">邮箱</label>
                                <input type="email" name="email" class="form-control">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 修改弹窗 -->
        <div class="modal fade" id="editModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">编辑用户</h5>
                        <button class="close" data-dismiss="modal"><span>&times;</span></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/user/update" method="post">
                        <input type="hidden" name="id" id="eid">
                        <div class="modal-body">
                            <div class="form-group">
                                <label>账号</label>
                                <input type="text" name="username" id="euser" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>姓名</label>
                                <input type="text" name="realName" id="ereal" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>角色</label>
                                <select name="role" id="erole" class="form-control" required>
                                    <option value="采购人">采购人</option>
                                    <option value="审批人">审批人</option>
                                    <option value="admin">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>电话</label>
                                <input type="text" name="phone" id="ephone" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>邮箱</label>
                                <input type="email" name="email" id="eemail" class="form-control">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">保存修改</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        //删除
        function deleteUser(id) {
            if (confirm("确定要删除该用户吗？")) {
                location.href="${pageContext.request.contextPath}/user/delete?id="+id;
            }
        }
        //回填修改数据
        function fillData(id,un,rn,ro,ph,em){
            document.getElementById("eid").value=id;
            document.getElementById("euser").value=un;
            document.getElementById("ereal").value=rn;
            document.getElementById("erole").value=ro;
            document.getElementById("ephone").value=ph;
            document.getElementById("eemail").value=em;
        }
    </script>
</body>
</html>