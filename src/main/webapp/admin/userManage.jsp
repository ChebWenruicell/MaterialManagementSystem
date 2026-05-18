<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <style>
        /* 新增样式 */
        .search-box {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .search-input {
            width: 300px;
        }
        
        .btn-sm {
            padding: 4px 8px;
            font-size: 12px;
        }
        
        .status-badge {
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
        }
        
        .status-enabled {
            background-color: #E8FFEA;
            color: #00B42A;
        }
        
        .status-disabled {
            background-color: #FFECE8;
            color: #F53F3F;
        }
        
        .batch-actions {
            margin-bottom: 16px;
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .loading {
            text-align: center;
            padding: 20px;
            color: #86909C;
        }
        
        .form-error {
            color: #F53F3F;
            font-size: 12px;
            margin-top: 4px;
            display: none;
        }
    </style>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">用户管理</h1>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">用户列表</h3>
                <div class="search-box">
                    <input type="text" id="searchInput" class="form-input search-input" placeholder="搜索账号/姓名/电话">
                    <button id="searchBtn" class="btn btn-primary">搜索</button>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">添加用户</button>
                </div>
            </div>
            
            <div class="batch-actions">
                <input type="checkbox" id="selectAll">
                <label for="selectAll">全选</label>
                <button id="batchDeleteBtn" class="btn btn-danger btn-sm" disabled>批量删除</button>
            </div>
            
            <table class="table">
                <thead>
                    <tr>
                        <th><input type="checkbox" class="row-checkbox"></th>
                        <th>账号</th>
                        <th>姓名</th>
                        <th>角色</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="userTableBody">
                    <c:forEach items="${userList}" var="user">
                        <tr data-user-id="${user.id}">
                            <td><input type="checkbox" class="row-checkbox" value="${user.id}"></td>
                            <td>${user.username}</td>
                            <td>${user.realName}</td>
                            <td>${user.role}</td>
                            <td>${user.phone}</td>
                            <td>${user.email}</td>
                            <td>
                                <span class="status-badge ${user.status == 1 ? 'status-enabled' : 'status-disabled'}">
                                    ${user.status == 1 ? '启用' : '禁用'}
                                </span>
                            </td>
                            <td>${user.createTime}</td>
                            <td>
                                <button class="btn btn-outline btn-sm edit-btn" data-id="${user.id}">编辑</button>
                                <c:if test="${user.username != sessionScope.loginUser.username}">
                                    <button class="btn btn-danger btn-sm delete-btn" data-id="${user.id}" data-name="${user.realName}">删除</button>
                                    <button class="btn ${user.status == 1 ? 'btn-outline' : 'btn-primary'} btn-sm toggle-status-btn" 
                                            data-id="${user.id}" data-status="${user.status}">
                                        ${user.status == 1 ? '禁用' : '启用'}
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="9" class="text-center text-muted">暂无用户数据</td>
                        </tr>
                    </c:if>
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
                    <form id="addUserForm" action="${pageContext.request.contextPath}/user/add" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">账号 <span style="color: red;">*</span></label>
                                <input type="text" name="account" class="form-input" required>
                                <div class="form-error">请输入账号</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">密码 <span style="color: red;">*</span></label>
                                <input type="password" name="password" class="form-input" required minlength="6">
                                <div class="form-error">密码至少6位</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">姓名 <span style="color: red;">*</span></label>
                                <input type="text" name="name" class="form-input" required>
                                <div class="form-error">请输入姓名</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">角色 <span style="color: red;">*</span></label>
                                <select name="role" class="form-input" required>
                                    <option value="采购人">采购人</option>
                                    <option value="审批人">审批人</option>
                                    <option value="admin">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">电话 <span style="color: red;">*</span></label>
                                <input type="text" name="phone" class="form-input" required pattern="^1[3-9]\d{9}$">
                                <div class="form-error">请输入正确的手机号</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">邮箱</label>
                                <input type="email" name="email" class="form-input">
                                <div class="form-error">请输入正确的邮箱格式</div>
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

        <!-- 编辑用户模态框 -->
        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">编辑用户</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="editUserForm" action="${pageContext.request.contextPath}/user/update" method="post">
                        <input type="hidden" name="id" id="editUserId">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">账号</label>
                                <input type="text" id="editUsername" class="form-input" readonly>
                            </div>
                            <div class="form-group">
                                <label class="form-label">姓名 <span style="color: red;">*</span></label>
                                <input type="text" name="name" id="editName" class="form-input" required>
                                <div class="form-error">请输入姓名</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">角色 <span style="color: red;">*</span></label>
                                <select name="role" id="editRole" class="form-input" required>
                                    <option value="采购人">采购人</option>
                                    <option value="审批人">审批人</option>
                                    <option value="admin">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">电话 <span style="color: red;">*</span></label>
                                <input type="text" name="phone" id="editPhone" class="form-input" required pattern="^1[3-9]\d{9}$">
                                <div class="form-error">请输入正确的手机号</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">邮箱</label>
                                <input type="email" name="email" id="editEmail" class="form-input">
                                <div class="form-error">请输入正确的邮箱格式</div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">重置密码（留空则不修改）</label>
                                <input type="password" name="password" class="form-input" minlength="6">
                                <div class="form-error">密码至少6位</div>
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

    <script>
        // 修复删除功能：改为发送表单数据而非JSON
        function deleteUser(id, name) {
            if (confirm(`确定要删除用户"${name}"吗？此操作不可恢复！`)) {
                fetch('${pageContext.request.contextPath}/user/delete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `id=${id}`
                }).then(res => res.json())
                  .then(data => {
                      alert(data.msg);
                      location.reload();
                  });
            }
        }

        // 切换用户状态
        function toggleUserStatus(id, currentStatus) {
            const action = currentStatus == 1 ? '禁用' : '启用';
            if (confirm(`确定要${action}该用户吗？`)) {
                fetch('${pageContext.request.contextPath}/user/toggleStatus', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `id=${id}&status=${currentStatus == 1 ? 0 : 1}`
                }).then(res => res.json())
                  .then(data => {
                      alert(data.msg);
                      location.reload();
                  });
            }
        }

        // 编辑用户
        function editUser(id) {
            // 这里可以通过AJAX获取用户详情，或者从表格中提取数据
            const row = document.querySelector(`tr[data-user-id="${id}"]`);
            const cells = row.querySelectorAll('td');
            
            document.getElementById('editUserId').value = id;
            document.getElementById('editUsername').value = cells[1].textContent;
            document.getElementById('editName').value = cells[2].textContent;
            document.getElementById('editRole').value = cells[3].textContent;
            document.getElementById('editPhone').value = cells[4].textContent;
            document.getElementById('editEmail').value = cells[5].textContent;
            
            $('#editUserModal').modal('show');
        }

        // 批量删除
        function batchDelete() {
            const selectedIds = Array.from(document.querySelectorAll('.row-checkbox:checked'))
                .filter(cb => cb.value) // 排除全选框
                .map(cb => cb.value);
                
            if (selectedIds.length === 0) {
                alert('请选择要删除的用户');
                return;
            }
            
            if (confirm(`确定要删除选中的${selectedIds.length}个用户吗？此操作不可恢复！`)) {
                fetch('${pageContext.request.contextPath}/user/batchDelete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `ids=${selectedIds.join(',')}`
                }).then(res => res.json())
                  .then(data => {
                      alert(data.msg);
                      location.reload();
                  });
            }
        }

        // 搜索功能
        function searchUsers() {
            const keyword = document.getElementById('searchInput').value.trim();
            // 这里可以通过AJAX请求后端进行搜索，或者前端过滤
            // 简单实现：前端过滤表格行
            const rows = document.querySelectorAll('#userTableBody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(keyword.toLowerCase()) ? '' : 'none';
            });
        }

        // 事件绑定
        document.addEventListener('DOMContentLoaded', function() {
            // 删除按钮
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const id = this.dataset.id;
                    const name = this.dataset.name;
                    deleteUser(id, name);
                });
            });

            // 状态切换按钮
            document.querySelectorAll('.toggle-status-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const id = this.dataset.id;
                    const status = this.dataset.status;
                    toggleUserStatus(id, status);
                });
            });

            // 编辑按钮
            document.querySelectorAll('.edit-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const id = this.dataset.id;
                    editUser(id);
                });
            });

            // 全选/取消全选
            document.getElementById('selectAll').addEventListener('change', function() {
                const checkboxes = document.querySelectorAll('.row-checkbox');
                checkboxes.forEach(cb => cb.checked = this.checked);
                document.getElementById('batchDeleteBtn').disabled = !this.checked;
            });

            // 单个复选框变化
            document.querySelectorAll('.row-checkbox').forEach(cb => {
                cb.addEventListener('change', function() {
                    const allChecked = Array.from(document.querySelectorAll('.row-checkbox'))
                        .every(cb => cb.checked);
                    document.getElementById('selectAll').checked = allChecked;
                    
                    const anyChecked = Array.from(document.querySelectorAll('.row-checkbox'))
                        .some(cb => cb.checked);
                    document.getElementById('batchDeleteBtn').disabled = !anyChecked;
                });
            });

            // 批量删除按钮
            document.getElementById('batchDeleteBtn').addEventListener('click', batchDelete);

            // 搜索按钮
            document.getElementById('searchBtn').addEventListener('click', searchUsers);
            document.getElementById('searchInput').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') searchUsers();
            });

            // 表单验证
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    let isValid = true;
                    const inputs = this.querySelectorAll('.form-input[required]');
                    
                    inputs.forEach(input => {
                        const errorDiv = input.nextElementSibling;
                        if (!input.value.trim()) {
                            errorDiv.style.display = 'block';
                            isValid = false;
                        } else {
                            errorDiv.style.display = 'none';
                        }
                        
                        // 验证手机号
                        if (input.name === 'phone' && input.value) {
                            const phoneRegex = /^1[3-9]\d{9}$/;
                            if (!phoneRegex.test(input.value)) {
                                errorDiv.style.display = 'block';
                                isValid = false;
                            }
                        }
                        
                        // 验证邮箱
                        if (input.type === 'email' && input.value) {
                            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                            if (!emailRegex.test(input.value)) {
                                errorDiv.style.display = 'block';
                                isValid = false;
                            }
                        }
                        
                        // 验证密码长度
                        if (input.type === 'password' && input.value && input.value.length < 6) {
                            errorDiv.style.display = 'block';
                            isValid = false;
                        }
                    });
                    
                    if (!isValid) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
    <!-- 引入Bootstrap模态框依赖 -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
</body>
</html>