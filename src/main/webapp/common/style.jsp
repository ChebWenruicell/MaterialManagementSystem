<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "PingFang SC", "Microsoft YaHei", sans-serif;
    }

    /* 渐变背景 */
    body {
        background: linear-gradient(135deg, #F0F7FF 0%, #E6F0FF 100%);
        color: #1D2129;
        line-height: 1.6;
        min-height: 100vh;
    }

    /* 顶部导航栏 */
    .header {
        height: 56px;
        background: #165DFF;
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;
        box-shadow: 0 2px 8px rgba(22, 93, 255, 0.15);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .header-logo {
        font-size: 20px;
        font-weight: 600;
        letter-spacing: 1px;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 24px;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
    }

    .user-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background-color: white;
        color: #165DFF;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 14px;
    }

    .logout-btn {
        color: white;
        text-decoration: none;
        font-size: 14px;
        padding: 6px 12px;
        border-radius: 4px;
        transition: background-color 0.2s;
    }

    .logout-btn:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    /* 左侧侧边栏 */
    .sidebar {
        width: 220px;
        background-color: white;
        height: calc(100vh - 56px);
        position: fixed;
        top: 56px;
        left: 0;
        box-shadow: 2px 0 12px rgba(0, 0, 0, 0.04);
        padding-top: 16px;
        overflow-y: auto;
        border-right: 1px solid #E8F3FF;
    }

    .sidebar-menu {
        list-style: none;
    }

    .sidebar-menu-item {
        margin-bottom: 4px;
    }

    .sidebar-menu-item a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 24px;
        color: #666;
        text-decoration: none;
        transition: all 0.2s;
        border-left: 3px solid transparent;
        font-size: 14px;
        border-radius: 0 8px 8px 0;
        margin: 0 8px;
    }

    .sidebar-menu-item a:hover,
    .sidebar-menu-item.active a {
        background-color: #E8F3FF;
        color: #165DFF;
        border-left-color: #165DFF;
    }

    .sidebar-menu-item .icon {
        width: 20px;
        height: 20px;
        text-align: center;
        font-size: 18px;
    }

    /* 主内容区 */
    .main-content {
        margin-left: 220px;
        margin-top: 56px;
        padding: 32px;
        min-height: calc(100vh - 56px);
    }

    /* 页面标题 */
    .page-title {
        font-size: 32px;
        font-weight: 600;
        margin-bottom: 32px;
        color: #1D2129;
    }

    /* 卡片 */
    .card {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 16px rgba(0, 0, 0, 0.06);
        padding: 32px;
        margin-bottom: 24px;
        border: 1px solid #F0F2F5;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
        padding-bottom: 16px;
        border-bottom: 1px solid #F0F2F5;
    }

    .card-title {
        font-size: 20px;
        font-weight: 600;
        color: #1D2129;
    }

    /* 按钮样式 */
    .btn {
        padding: 10px 20px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.2s;
        text-decoration: none;
        display: inline-block;
        text-align: center;
    }

    .btn-primary {
        background-color: #165DFF;
        color: white;
    }

    .btn-primary:hover {
        background-color: #0E42D2;
        box-shadow: 0 4px 12px rgba(22, 93, 255, 0.3);
    }

    .btn-outline {
        background-color: white;
        color: #165DFF;
        border: 1px solid #165DFF;
    }

    .btn-outline:hover {
        background-color: #E8F3FF;
    }

    .btn-danger {
        background-color: #F53F3F;
        color: white;
    }

    .btn-danger:hover {
        background-color: #D93030;
        box-shadow: 0 4px 12px rgba(245, 63, 63, 0.3);
    }

    .btn-sm {
        padding: 6px 12px;
        font-size: 12px;
    }

    /* 表格样式 */
    .table {
        width: 100%;
        border-collapse: collapse;
    }

    .table th,
    .table td {
        padding: 14px 16px;
        text-align: left;
        border-bottom: 1px solid #F0F2F5;
    }

    .table th {
        background-color: #F7F8FA;
        font-weight: 600;
        color: #4E5969;
        border-radius: 8px 8px 0 0;
    }

    .table tr:hover {
        background-color: #F7F8FA;
    }

    /* 表单样式 */
    .form-group {
        margin-bottom: 24px;
    }

    .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #4E5969;
        font-size: 14px;
    }

    .form-input {
        width: 100%;
        padding: 12px 16px;
        border: 1px solid #DCDFE6;
        border-radius: 8px;
        font-size: 14px;
        transition: all 0.2s;
        background-color: white;
    }

    .form-input:focus {
        outline: none;
        border-color: #165DFF;
        box-shadow: 0 0 0 3px rgba(22, 93, 255, 0.1);
    }

    .form-textarea {
        resize: vertical;
        min-height: 120px;
        line-height: 1.8;
    }

    .form-text {
        font-size: 12px;
        color: #86909C;
        margin-top: 4px;
    }

    /* 统计卡片 */
    .stat-card {
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 16px rgba(0, 0, 0, 0.06);
        padding: 32px;
        text-align: center;
        border: 1px solid #F0F2F5;
        transition: transform 0.2s;
        position: relative;
        overflow: hidden;
    }

    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, rgba(22, 93, 255, 0.1) 0%, rgba(22, 93, 255, 0.05) 100%);
        border-radius: 0 0 0 100%;
    }

    .stat-card:hover {
        transform: translateY(-4px);
    }

    .stat-icon {
        position: absolute;
        top: 24px;
        right: 24px;
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }

    .stat-icon-blue {
        background-color: #E8F3FF;
        color: #165DFF;
    }

    .stat-icon-green {
        background-color: #E8FFEA;
        color: #00B42A;
    }

    .stat-icon-orange {
        background-color: #FFF7E8;
        color: #FF7D00;
    }

    .stat-icon-red {
        background-color: #FFECE8;
        color: #F53F3F;
    }

    .stat-number {
        font-size: 40px;
        font-weight: 700;
        color: #165DFF;
        margin-bottom: 8px;
        text-align: left;
    }

    .stat-label {
        font-size: 14px;
        color: #86909C;
        text-align: left;
    }

    /* 网格布局 */
    .row {
        display: flex;
        flex-wrap: wrap;
        margin: 0 -12px;
    }

    .col-3 {
        width: 25%;
        padding: 0 12px;
        margin-bottom: 24px;
    }

    .col-4 {
        width: 33.333%;
        padding: 0 12px;
        margin-bottom: 24px;
    }

    .col-6 {
        width: 50%;
        padding: 0 12px;
        margin-bottom: 24px;
    }

    .col-12 {
        width: 100%;
        padding: 0 12px;
        margin-bottom: 24px;
    }

    /* 待办事项 */
    .todo-item {
        padding: 14px 0;
        border-bottom: 1px solid #F0F2F5;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .todo-item:last-child {
        border-bottom: none;
    }

    .todo-status {
        padding: 4px 10px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 500;
    }

    .status-warning {
        background-color: #FFF7E8;
        color: #FF7D00;
    }

    .status-danger {
        background-color: #FFECE8;
        color: #F53F3F;
    }

    .status-success {
        background-color: #E8FFEA;
        color: #00B42A;
    }

    /* 登录页面 */
    .login-page {
        width: 100%;
        height: 100vh;
        display: flex;
        overflow: hidden;
    }

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

    /* AI助手专属样式 */
    .ai-robot {
        width: 120px;
        height: 120px;
        margin: 0 auto 24px;
        background: linear-gradient(135deg, #165DFF 0%, #4080FF 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 60px;
        box-shadow: 0 8px 24px rgba(22, 93, 255, 0.3);
    }

    .ai-title {
        text-align: center;
        font-size: 36px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .ai-title span {
        background: linear-gradient(90deg, #165DFF 0%, #722ED1 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .ai-subtitle {
        text-align: center;
        color: #86909C;
        font-size: 16px;
        margin-bottom: 32px;
    }

    .ai-input-container {
        position: relative;
        margin-bottom: 24px;
    }

    .ai-input {
        width: 100%;
        padding: 16px 60px 16px 16px;
        border: 2px solid #DCDFE6;
        border-radius: 12px;
        font-size: 16px;
        transition: all 0.2s;
        min-height: 120px;
        line-height: 1.8;
    }

    .ai-input:focus {
        border-color: #165DFF;
        box-shadow: 0 0 0 3px rgba(22, 93, 255, 0.1);
    }

    .ai-send-btn {
        position: absolute;
        right: 16px;
        bottom: 16px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: #165DFF;
        color: white;
        border: none;
        cursor: pointer;
        font-size: 18px;
        transition: all 0.2s;
    }

    .ai-send-btn:hover {
        background-color: #0E42D2;
        transform: scale(1.1);
    }

    /* 提示信息 */
    .alert {
        padding: 16px 20px;
        border-radius: 8px;
        margin-bottom: 24px;
        border: none;
    }

    .alert-success {
        background-color: #E8FFEA;
        color: #00B42A;
    }

    .alert-danger {
        background-color: #FFECE8;
        color: #F53F3F;
    }

    /* 快捷操作按钮 */
    .quick-actions {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
        margin-bottom: 24px;
    }

    .quick-action-btn {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        padding: 20px;
        background-color: white;
        border-radius: 12px;
        text-decoration: none;
        color: #4E5969;
        transition: all 0.2s;
        border: 1px solid #F0F2F5;
    }

    .quick-action-btn:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        color: #165DFF;
    }

    .quick-action-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        background-color: #E8F3FF;
        color: #165DFF;
    }

    /* 文本居中 */
    .text-center {
        text-align: center;
    }

    .text-muted {
        color: #86909C;
    }
</style>