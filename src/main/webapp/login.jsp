<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/style.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资采购管理系统</title>
    <style>
        /* 登录页专属样式 */
        .login-page {
            width: 100%;
            height: 100vh;
            display: flex;
            overflow: hidden;
        }

        /* 左侧品牌区域 */
        .login-left {
            width: 50%;
            background: linear-gradient(135deg, #165DFF 0%, #4080FF 50%, #69B1FF 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            position: relative;
        }

        .login-left::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxkZWZzPjxwYXR0ZXJuIGlkPSJncmlkIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiPjxwYXRoIGQ9Ik0gNDAgMCBMIDAgMCAwIDQwIiBmaWxsPSJub25lIiBzdHJva2U9InJnYmEoMjU1LDI1NSwyNTUsMC4xKSIgc3Ryb2tlLXdpZHRoPSIxIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2dyaWQpIi8+PC9zdmc+');
            opacity: 0.3;
        }

        .login-logo {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 16px;
            z-index: 1;
        }

        .login-subtitle {
            font-size: 20px;
            opacity: 0.9;
            margin-bottom: 64px;
            z-index: 1;
        }

        .login-features {
            display: flex;
            gap: 48px;
            z-index: 1;
        }

        .feature-item {
            text-align: center;
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 12px;
        }

        .feature-text {
            font-size: 16px;
            opacity: 0.9;
        }

        /* 右侧登录表单区域 */
        .login-right {
            width: 50%;
            background-color: #F5F7FA;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            width: 480px;
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            padding: 48px;
        }

        .login-card-title {
            font-size: 28px;
            font-weight: 600;
            color: #1D2129;
            margin-bottom: 8px;
            text-align: center;
        }

        .login-card-subtitle {
            color: #86909C;
            font-size: 14px;
            margin-bottom: 32px;
            text-align: center;
        }

        .form-input {
            height: 48px;
            font-size: 16px;
        }

        .login-btn {
            height: 48px;
            font-size: 16px;
            font-weight: 600;
            margin-top: 8px;
        }

        .test-accounts {
            margin-top: 32px;
            padding: 16px;
            background-color: #F7F8FA;
            border-radius: 8px;
            font-size: 13px;
            color: #666;
        }

        .test-accounts-title {
            font-weight: 600;
            margin-bottom: 8px;
            color: #4E5969;
        }
    </style>
</head>
<body>
    <div class="login-page">
        <!-- 左侧品牌区域 -->
        <div class="login-left">
            <div class="login-logo">物资采购管理系统</div>
            <div class="login-subtitle">物资采购管理智能体</div>
            
            <div class="login-features">
                <div class="feature-item">
                    <div class="feature-icon">🤖</div>
                    <div class="feature-text">AI智能生成</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">📋</div>
                    <div class="feature-text">全流程管理</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">🔒</div>
                    <div class="feature-text">安全合规</div>
                </div>
            </div>
        </div>

        <!-- 右侧登录表单 -->
        <div class="login-right">
            <div class="login-card">
                <h2 class="login-card-title">欢迎登录</h2>
                <p class="login-card-subtitle">物资采购管理系统</p>
                
                <!-- ✅ 修正1：错误信息显示优化，加上Bootstrap的alert样式 -->
                <% if (request.getAttribute("errorMsg") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin-bottom: 24px;">
                        <%= request.getAttribute("errorMsg") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                
                <!-- ✅ 修正2：表单action加上项目上下文路径，避免404 -->
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                        <label class="form-label">用户名</label>
                        <input type="text" name="username" class="form-control form-input" placeholder="请输入用户名" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">密码</label>
                        <input type="password" name="password" class="form-control form-input" placeholder="请输入密码" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary login-btn" style="width: 100%;">登录</button>
                </form>
                
                <div class="test-accounts">
                    <div class="test-accounts-title">测试账号</div>
                    <div>管理员：admin / 123456</div>
                    <div>采购人：purchaser01 / 123456</div>
                    <div>审批人：approver01 / 123456</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>