<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/purchase/aiGenerate -->
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI生成采购单</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
</head>
<body>
    <%@ include file="../common/sidebar_purchaser.jsp" %>
    <div class="main-content">
        <!-- AI机器人头部 -->
        <div class="ai-robot">🤖</div>
        <h1 class="ai-title"><span>AI一键生成</span> 采购申请单</h1>
        <p class="ai-subtitle">输入采购需求，AI自动解析并生成完整采购申请单</p>
        
        <div class="card">
            <!-- AI输入区域 -->
            <div class="ai-input-container">
                <textarea id="demand" class="ai-input" placeholder="请输入详细的采购需求，例如：给10人办公室采购1个月的办公用品，包括中性笔、笔记本、打印纸等"></textarea>
                <button id="generateBtn" class="ai-send-btn">➤</button>
            </div>
            
            <!-- 模板分类 -->
            <div style="margin-top: 32px;">
                <div style="display: flex; gap: 16px; justify-content: center; margin-bottom: 24px; flex-wrap: wrap;">
                    <button class="btn btn-outline btn-sm">办公用品类</button>
                    <button class="btn btn-outline btn-sm">IT设备类</button>
                    <button class="btn btn-outline btn-sm">劳保用品类</button>
                    <button class="btn btn-outline btn-sm">办公家具类</button>
                    <button class="btn btn-outline btn-sm">自定义模板</button>
                </div>
            </div>
            
            <!-- 生成结果区域 -->
            <div id="resultArea" style="margin-top: 40px; display: none;">
                <div class="card-header">
                    <h3 class="card-title">AI生成结果（可编辑后提交）</h3>
                </div>
                <form action="${pageContext.request.contextPath}/purchaser/purchaseApply.jsp" method="post">
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label">申请部门</label>
                                <input type="text" name="dept" id="dept" class="form-input" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label">物资名称</label>
                                <input type="text" name="item" id="item" class="form-input" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label">规格型号</label>
                                <input type="text" name="spec" id="spec" class="form-input" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label class="form-label">数量</label>
                                <input type="number" name="num" id="num" class="form-input" min="1" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">用途</label>
                        <textarea name="usage" id="usage" class="form-input form-textarea" required></textarea>
                    </div>
                    
                    <div style="text-align: right;">
                        <button type="button" id="regenerateBtn" class="btn btn-outline" style="margin-right: 12px;">重新生成</button>
                        <button type="submit" class="btn btn-primary">提交采购申请</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // 生成按钮点击事件
        document.getElementById('generateBtn').addEventListener('click', generatePurchase);
        document.getElementById('regenerateBtn').addEventListener('click', generatePurchase);
        
        function generatePurchase() {
            const demand = document.getElementById('demand').value;
            if (!demand.trim()) {
                alert('请输入采购需求');
                return;
            }
            
            // 显示加载状态
            document.getElementById('generateBtn').disabled = true;
            document.getElementById('generateBtn').innerHTML = '⏳';
            
            // 模拟AI生成（后期对接真实Servlet）
            setTimeout(() => {
                document.getElementById('dept').value = '办公室';
                document.getElementById('item').value = '中性笔';
                document.getElementById('spec').value = '黑色0.5mm';
                document.getElementById('num').value = '20';
                document.getElementById('usage').value = '日常办公使用';
                
                // 显示结果区域
                document.getElementById('resultArea').style.display = 'block';
                document.getElementById('resultArea').scrollIntoView({behavior: 'smooth'});
            }, 1000)
            .finally(() => {
                document.getElementById('generateBtn').disabled = false;
                document.getElementById('generateBtn').innerHTML = '➤';
            });
        }
        
        // 回车键提交
        document.getElementById('demand').addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && e.ctrlKey) {
                generatePurchase();
            }
        });
    </script>
</body>
</html>