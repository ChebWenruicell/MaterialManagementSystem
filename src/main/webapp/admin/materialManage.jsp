<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资管理</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="/common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">物资管理</h1>
        
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-3">
                <h3 class="card-title mb-0">物资列表</h3>
                <!-- 新增：按物资名称搜索区域 -->
                <form action="${pageContext.request.contextPath}/material/list" method="get" class="form-inline">
                    <input type="text" name="keyword" class="form-control mr-2" placeholder="输入物资名称搜索" value="${keyword}">
                    <button type="submit" class="btn btn-success">搜索</button>
                    <a href="${pageContext.request.contextPath}/material/list" class="btn btn-outline-secondary ml-2">重置</a>
                </form>
                <button class="btn btn-primary" data-toggle="modal" data-target="#addMaterialModal">添加物资</button>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>物资名称</th>
                        <th>规格型号</th>
                        <th>单价</th>
                        <th>单位</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="material">
                        <tr>
                            <td>${material.materialName}</td>
                            <td>${material.spec}</td>
                            <td>¥${material.price}</td>
                            <td>${material.unit}</td>
                            <td>${material.createTime}</td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary" 
                                        data-toggle="modal" 
                                        data-target="#editMaterialModal"
                                        data-id="${material.id}"
                                        data-name="${material.materialName}"
                                        data-spec="${material.spec}"
                                        data-price="${material.price}"
                                        data-unit="${material.unit}">编辑</button>

                                <button class="btn btn-sm btn-outline-danger" onclick="deleteMaterial(${material.id})">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <%-- 无搜索结果提示 --%>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">暂无匹配的物资数据</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <!-- 添加物资模态框 -->
        <div class="modal fade" id="addMaterialModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">添加物资</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/material/add" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">物资名称</label>
                                <input type="text" name="materialName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">规格型号</label>
                                <input type="text" name="spec" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">单价</label>
                                <input type="number" step="0.01" name="price" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">单位</label>
                                <input type="text" name="unit" class="form-control" required>
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

        <!-- 编辑物资模态框 -->
        <div class="modal fade" id="editMaterialModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">编辑物资</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/material/update" method="post">
                        <input type="hidden" name="id" id="editId">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">物资名称</label>
                                <input type="text" name="materialName" id="editName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">规格型号</label>
                                <input type="text" name="spec" id="editSpec" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">单价</label>
                                <input type="number" step="0.01" name="price" id="editPrice" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">单位</label>
                                <input type="text" name="unit" id="editUnit" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">保存修改</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 编辑弹窗数据回填
        $('#editMaterialModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            $('#editId').val(button.data('id'));
            $('#editName').val(button.data('name'));
            $('#editSpec').val(button.data('spec'));
            $('#editPrice').val(button.data('price'));
            $('#editUnit').val(button.data('unit'));
        });

        // 删除物资确认
        function deleteMaterial(id) {
            if (confirm("确定要删除该物资吗？")) {
                location.href="${pageContext.request.contextPath}/material/delete?id="+id;
            }
        }
    </script>
</body>
</html>