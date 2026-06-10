<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购模板管理</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">采购模板管理</h1>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">模板列表</h3>
                <button class="btn btn-primary" data-toggle="modal" data-target="#addTemplateModal">添加模板</button>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>模板名称</th>
                        <th>表单字段</th>
                        <th>必填字段</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${templateList}" var="template">
                        <tr>
                            <td>${template.templateName}</td>
                            <td>${template.fieldList}</td>
                            <td>${template.requiredList}</td>
                            <td>${template.status == 1 ? '启用' : '停用'}</td>
                            <td>${template.createTime}</td>
                            <td>
                                <button class="btn btn-info btn-sm" onclick="openConfig(${template.id},'${template.templateName}','${template.fieldList}','${template.requiredList}',${template.status})">配置</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteTemplate(${template.id})">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- 添加模板模态框 -->
        <div class="modal fade" id="addTemplateModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">添加采购模板</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/template/add" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">模板名称</label>
                                <input type="text" name="templateName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">表单字段（逗号分隔）</label>
                                <input type="text" name="fieldList" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">必填字段（逗号分隔）</label>
                                <input type="text" name="requiredList" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">状态</label>
                                <select name="status" class="form-control">
                                    <option value="1">启用</option>
                                    <option value="0">停用</option>
                                </select>
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

        <!-- 配置模板弹窗 -->
        <div class="modal fade" id="configModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">模板配置</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="${pageContext.request.contextPath}/template/update" method="post">
                        <input type="hidden" name="id" id="configId">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">模板名称</label>
                                <input type="text" name="templateName" id="configName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">表单字段</label>
                                <input type="text" name="fieldList" id="configField" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">必填字段</label>
                                <input type="text" name="requiredList" id="configRequired" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">状态</label>
                                <select name="status" id="configStatus" class="form-control">
                                    <option value="1">启用</option>
                                    <option value="0">停用</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">保存配置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function openConfig(id, name, field, req, status) {
            $("#configId").val(id);
            $("#configName").val(name);
            $("#configField").val(field);
            $("#configRequired").val(req);
            $("#configStatus").val(status);
            $("#configModal").modal("show");
        }

        function deleteTemplate(id) {
            if (confirm("确定要删除该模板吗？")) {
                location.href="${pageContext.request.contextPath}/template/delete?id="+id;
            }
        }
    </script>
</body>
</html>