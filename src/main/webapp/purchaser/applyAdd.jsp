<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>新增采购申请</title>
    <style>
        table{margin:20px auto; border-collapse:collapse; width:70%;}
        td{padding:10px; border:1px solid #ccc;}
        .ai-box{
            text-align:center;
            margin:25px 0;
        }
        .ai-btn{
            background:#28a745;
            color:#fff;
            border:none;
            padding:8px 22px;
            border-radius:4px;
            font-size:15px;
            cursor:pointer;
        }
    </style>
</head>
<body>
<h2 align="center">新增采购申请</h2>

<div class="ai-box">
    <a href="${pageContext.request.contextPath}/purchaser/aiCreate">
        <button class="ai-btn">AI一键自动生成采购单并提交入库</button>
    </a>
</div>

<form action="${pageContext.request.contextPath}/purchaser/add" method="post">
    <table>
        <tr>
            <td>申请部门：</td>
            <td><input type="text" name="dept" value="${param.dept}" required></td>
        </tr>
        <tr>
            <td>物品名称：</td>
            <td><input type="text" name="item" value="${param.item}" required></td>
        </tr>
        <tr>
            <td>规格型号：</td>
            <td><input type="text" name="spec" value="${param.spec}"></td>
        </tr>
        <tr>
            <td>采购数量：</td>
            <td><input type="number" name="num" value="${param.num}" required></td>
        </tr>
        <tr>
            <td>用途描述：</td>
            <td><textarea name="usage" rows="4" required>${param.usage}</textarea></td>
        </tr>
        <tr>
            <td>附件路径：</td>
            <td><input type="text" name="filePath" placeholder="可不填" value="${param.filePath}"></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="手动提交采购申请" style="padding:6px 20px;">
            </td>
        </tr>
    </table>
</form>

</body>
</html>