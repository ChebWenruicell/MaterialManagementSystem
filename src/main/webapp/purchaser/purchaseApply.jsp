<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/purchase/submit -->
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交采购申请</title>
</head>
<body>
    <%@ include file="../common/sidebar_purchaser.jsp" %>
    <div class="main-content">
        <h1 class="page-title">提交采购申请</h1>
        
        <div class="card">
            <form action="${pageContext.request.contextPath}/purchaser/purchaseApply.jsp" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">申请部门</label>
                            <input type="text" name="dept" class="form-input" required placeholder="请输入申请部门">
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">物资名称</label>
                            <input type="text" name="item" class="form-input" required placeholder="请输入物资名称">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">规格型号</label>
                            <input type="text" name="spec" class="form-input" required placeholder="请输入规格型号">
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">数量</label>
                            <input type="number" name="num" class="form-input" min="1" value="1" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">用途</label>
                    <textarea name="usage" class="form-input form-textarea" required placeholder="请输入采购用途"></textarea>
                </div>
                
                <div class="form-group">
                    <label class="form-label">附件（可选）</label>
                    <input type="file" name="file" class="form-input">
                </div>
                
                <div style="text-align: right;">
                    <button type="reset" class="btn btn-outline" style="margin-right: 12px;">重置</button>
                    <button type="submit" class="btn btn-primary">提交采购申请</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>