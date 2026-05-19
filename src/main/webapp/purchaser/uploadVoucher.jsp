<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/upload -->
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>上传采购凭证</title>
</head>
<body>
    <%@ include file="../common/sidebar_purchaser.jsp" %>
    <div class="main-content">
        <h1 class="page-title">上传采购凭证</h1>
        
        <div class="card">
            <form action="${pageContext.request.contextPath}/purchaser/uploadVoucher.jsp" method="post" enctype="multipart/form-data">
                <input type="hidden" name="purchaseId" value="${param.purchaseId}">
                <div class="form-group">
                    <label class="form-label">采购单号</label>
                    <input type="text" class="form-input" value="${purchase.purchaseNo}" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label">上传凭证（发票/收货单）</label>
                    <input type="file" name="file" class="form-input" required>
                </div>
                <div class="form-group">
                    <label class="form-label">更新采购状态</label>
                    <select name="status" class="form-input" required>
                        <option value="采购中">采购中</option>
                        <option value="已完成">已完成</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">上传并更新状态</button>
            </form>
        </div>
    </div>
</body>
</html>