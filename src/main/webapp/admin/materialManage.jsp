<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/material/list -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资管理</title>
</head>
<body>
    <%@ include file="../common/sidebar_admin.jsp" %>
    <div class="main-content">
        <h1 class="page-title">物资管理</h1>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">物资列表</h3>
                <button class="btn btn-primary" data-toggle="modal" data-target="#addMaterialModal">添加物资</button>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>物资名称</th>
                        <th>规格型号</th>
                        <th>单价</th>
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
                    <form action="${pageContext.request.contextPath}/admin/materialManage.jsp" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">物资名称</label>
                                <input type="text" name="materialName" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">规格型号</label>
                                <input type="text" name="spec" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">单价</label>
                                <input type="number" step="0.01" name="price" class="form-input" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">单位</label>
                                <input type="text" name="unit" class="form-input" required>
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
</body>
</html>