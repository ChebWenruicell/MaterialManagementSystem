<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交采购申请</title>
    <style>
        .modal-mask {
            position: fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);display:none;z-index:9999;
        }
        .modal-box {
            width:700px;background:#fff;margin:120px auto;padding:20px;border-radius:8px;
        }
        .modal-header {display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;}
        .template-item {
            padding:10px 12px;border:1px solid #eee;border-radius:6px;margin-bottom:8px;cursor:pointer;
        }
        .template-item:hover {background:#f0f7ff;border-color:#4096ff;}
        /* 修复下拉框定位，紧贴输入框 */
        .suggest-box {
            border:1px solid #ddd;border-top:none;display:none;max-height:220px;overflow-y:auto;background:#fff;
            position:absolute;z-index:9999;
            left:0;
            right:0;
            top:calc(100% - 1px);
        }
        .suggest-item {padding:8px 12px;cursor:pointer;}
        .suggest-item:hover {background:#f5f7fa;}
        .form-group {position:relative;}
    </style>
</head>
<body>
    <%@ include file="../common/sidebar_purchaser.jsp" %>
    <div class="main-content">
        <h1 class="page-title">提交采购申请</h1>

        <div style="margin-bottom:16px;text-align:right;">
            <button type="button" class="btn btn-success" onclick="openTemplateModal()">选择采购模板</button>
        </div>
        
        <div class="card">
            <form id="purchaseForm" action="${pageContext.request.contextPath}/purchase/submit" method="post" enctype="multipart/form-data" onsubmit="return checkMaterialValid()">
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">申请部门</label>
                            <input type="text" name="dept" id="dept" class="form-input" required placeholder="请输入申请部门">
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">物资名称（输入关键字选择系统内置物资）</label>
                            <input type="text" name="item" id="item" class="form-input" required placeholder="输入关键字匹配物资"
                                   oninput="searchMaterial(this.value)" onblur="checkInputMaterial()">
                            <div class="suggest-box" id="suggestBox"></div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">规格型号（自动填充，不可修改）</label>
                            <input type="text" name="spec" id="spec" class="form-input" required readonly placeholder="选择物资自动填充">
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label class="form-label">数量</label>
                            <input type="number" name="num" id="num" class="form-input" min="1" value="1" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">用途</label>
                    <textarea name="usage" id="usage" class="form-input form-textarea" required placeholder="请输入采购用途"></textarea>
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

    <!-- 采购模板弹窗 修复：拆分field_list，不再直接读取t.dept/t.item，解决500空白 -->
    <div class="modal-mask" id="templateMask">
        <div class="modal-box">
            <div class="modal-header">
                <h4>管理员预设采购模板</h4>
                <button type="button" onclick="closeTemplateModal()">×</button>
            </div>
            <div id="templateList">
                <%-- 空模板兜底，不会渲染报错 --%>
                <c:if test="${empty templateList}">
                    <div style="padding:20px;text-align:center;color:#999;">暂无可用采购模板</div>
                </c:if>
                <c:forEach items="${templateList}" var="t">
                    <%
                    // 拆分数据库field_list字段：部门,物资,规格,用途
                    String fieldStr = ((com.material.bean.PurchaseTemplate)pageContext.getAttribute("t")).getFieldList();
                    String[] arr = fieldStr.split(",");
                    pageContext.setAttribute("d",arr[0]);
                    pageContext.setAttribute("i",arr[1]);
                    pageContext.setAttribute("s",arr[2]);
                    pageContext.setAttribute("u",arr[3]);
                    %>
                    <div class="template-item" onclick="fillTemplate('${d}','${i}','${s}','${u}')">
                        <div><strong>模板：${t.templateName}</strong></div>
                        <div>部门：${d} | 物资：${i}</div>
                        <div>规格：${s} | 用途：${u}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script>
    // 全局缓存全部合法物资，用于校验
    let allMaterialList = [];

    // 页面加载预加载全部物资
    $(function(){
        $.get("${pageContext.request.contextPath}/purchaser/searchMaterial",{keyword:""},function(res){
            allMaterialList = res;
        })
    })

    // 模板弹窗开关
    function openTemplateModal(){
        $('#templateMask').css('display','block');
    }
    function closeTemplateModal(){
        $('#templateMask').css('display','none');
    }
    // 填充模板数据
    function fillTemplate(dept,item,spec,usage){
        $('#dept').val(dept);
        $('#item').val(item);
        $('#spec').val(spec);
        $('#usage').val(usage);
        closeTemplateModal();
    }

    // 输入关键字实时查询物资，弹出下拉联想框
    function searchMaterial(keyword){
        let box = document.getElementById('suggestBox');
        box.innerHTML = '';
        if(keyword.trim() === ''){
            box.style.display = 'none';
            return;
        }
        $.get("${pageContext.request.contextPath}/purchaser/searchMaterial",{keyword:keyword},function(res){
            if(res.length === 0){
                box.style.display = 'none';
                return;
            }
            res.forEach(function(m){
                let div = document.createElement('div');
                div.className = 'suggest-item';
                div.innerText = m.materialName + " | 规格："+m.spec + " | 单位："+m.unit;
                // 点击条目自动回填物资+规格
                div.onclick = function(){
                    $('#item').val(m.materialName);
                    $('#spec').val(m.spec);
                    box.style.display = 'none';
                }
                box.appendChild(div);
            })
            box.style.display = 'block';
        })
    }

    // 输入框失去焦点校验：手动输入内容不在库内则清空
    function checkInputMaterial(){
        let inputVal = $('#item').val().trim();
        if(inputVal === "") return;
        let exist = allMaterialList.some(m => m.materialName === inputVal);
        if(!exist){
            alert("请从下拉列表中选择系统内已录入物资，不可自定义物资名称！");
            $('#item').val("");
            $('#spec').val("");
        }
    }

    // 表单提交最终校验
    function checkMaterialValid(){
        let inputVal = $('#item').val().trim();
        let exist = allMaterialList.some(m => m.materialName === inputVal);
        if(!exist){
            alert("物资名称无效，请选择下拉列表中的物资");
            $('#item').val("");
            $('#spec').val("");
            return false;
        }
        return true;
    }

    // 点击页面空白处关闭下拉框
    $(document).click(function(e){
        if(!$('#item').is(e.target) && !$('#suggestBox').is(e.target)){
            $('#suggestBox').css('display','none');
        }
    })
</script>
</body>
</html>