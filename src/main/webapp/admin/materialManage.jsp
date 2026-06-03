<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资管理</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">物资管理</h1>
        
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3 class="card-title mb-0">物资列表</h3>
                <button class="btn btn-primary" data-toggle="modal" data-target="#addMaterialModal">添加物资</button>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>物资名称</th>
                            <th>规格型号</th>
                            <th>单价（元）</th>
                            <th>单位</th>
                            <th>创建时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${materialList}" var="material">
                            <tr>
                                <td>${material.materialName}</td>
                                <td>${material.spec}</td>
                                <td>${material.price}</td>
                                <td>${material.unit}</td>
                                <td>${material.createTime}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty materialList}">
                            <tr>
                                <td colspan="5" class="text-center text-muted">暂无物资数据</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 添加物资模态框 -->
        <div class="modal fade" id="addMaterialModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">添加物资</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- 表单提交到MaterialServlet -->
                    <form action="${pageContext.request.contextPath}/material" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">物资名称 <span class="text-danger">*</span></label>
                                <input type="text" name="materialName" class="form-control" required placeholder="请输入物资名称">
                            </div>
                            <div class="form-group">
                                <label class="form-label">规格型号 <span class="text-danger">*</span></label>
                                <input type="text" name="spec" class="form-control" required placeholder="请输入规格型号">
                            </div>
                            <div class="form-group">
                                <label class="form-label">单价（元） <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" min="0" name="price" class="form-control" required placeholder="请输入单价">
                            </div>
                            <div class="form-group">
                                <label class="form-label">单位 <span class="text-danger">*</span></label>
                                <input type="text" name="unit" class="form-control" required placeholder="如：个、箱、件">
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
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>