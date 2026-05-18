<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Microsoft YaHei", "PingFang SC", sans-serif;
    }

    body {
        /* 背景色进一步调浅：从 #FAFBFC 改为 #FCFDFE */
        background-color: #FCFDFE;
        color: #333;
        line-height: 1.6;
    }

    /* 顶部导航栏 */
    .header {
        height: 56px;
        background: linear-gradient(90deg, #165DFF 0%, #4080FF 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;
        box-shadow: 0 1px 6px rgba(0, 0, 0, 0.06);
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
        box-shadow: 1px 0 4px rgba(0, 0, 0, 0.03);
        padding-top: 16px;
        overflow-y: auto;
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
    }

    .sidebar-menu-item a:hover,
    .sidebar-menu-item.active a {
        /* 侧边栏hover背景同步调浅 */
        background-color: #F5F9FF;
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
        padding: 24px;
        min-height: calc(100vh - 56px);
    }

    /* 页面标题 */
    .page-title {
        font-size: 28px;
        font-weight: 600;
        margin-bottom: 24px;
        color: #1D2129;
    }

    /* 卡片组件 */
    .card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 1px 8px rgba(0, 0, 0, 0.04);
        padding: 24px;
        margin-bottom: 24px;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 12px;
        /* 卡片底边框同步调浅 */
        border-bottom: 1px solid #F5F7FA;
    }

    .card-title {
        font-size: 18px;
        font-weight: 600;
        color: #1D2129;
    }

    /* 按钮样式 */
    .btn {
        padding: 8px 16px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        font-size: 14px;
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
    }

    .btn-outline {
        background-color: white;
        color: #165DFF;
        border: 1px solid #165DFF;
    }

    .btn-outline:hover {
        /* 按钮hover背景同步调浅 */
        background-color: #F5F9FF;
    }

    .btn-danger {
        background-color: #F53F3F;
        color: white;
    }

    .btn-danger:hover {
        background-color: #D93030;
    }

    /* 表格样式 */
    .table {
        width: 100%;
        border-collapse: collapse;
    }

    .table th,
    .table td {
        padding: 12px 16px;
        text-align: left;
        /* 表格边框同步调浅 */
        border-bottom: 1px solid #F5F7FA;
    }

    .table th {
        /* 表格表头背景同步调浅 */
        background-color: #FCFDFE;
        font-weight: 600;
        color: #4E5969;
    }

    .table tr:hover {
        /* 表格行hover背景同步调浅 */
        background-color: #FCFDFE;
    }

    /* 表单样式 */
    .form-group {
        margin-bottom: 20px;
    }

    .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #4E5969;
    }

    .form-input {
        width: 100%;
        padding: 10px 12px;
        /* 输入框边框同步调浅 */
        border: 1px solid #E5E6EB;
        border-radius: 4px;
        font-size: 14px;
        transition: border-color 0.2s;
    }

    .form-input:focus {
        outline: none;
        border-color: #165DFF;
        box-shadow: 0 0 0 2px rgba(22, 93, 255, 0.1);
    }

    .form-textarea {
        resize: vertical;
        min-height: 100px;
    }

    /* 统计卡片 */
    .stat-card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 1px 8px rgba(0, 0, 0, 0.04);
        padding: 24px;
        text-align: center;
    }

    .stat-number {
        font-size: 36px;
        font-weight: 700;
        color: #165DFF;
        margin-bottom: 8px;
    }

    .stat-label {
        font-size: 14px;
        color: #86909C;
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
        padding: 12px 0;
        /* 待办事项分割线同步调浅 */
        border-bottom: 1px solid #F5F7FA;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .todo-item:last-child {
        border-bottom: none;
    }

    .todo-status {
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
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
    .login-container {
        width: 100%;
        height: 100vh;
        background: linear-gradient(135deg, #165DFF 0%, #4080FF 50%, #69B1FF 100%);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .login-card {
        width: 400px;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 6px 24px rgba(0, 0, 0, 0.12);
        padding: 40px;
    }

    .login-title {
        text-align: center;
        font-size: 24px;
        font-weight: 600;
        color: #1D2129;
        margin-bottom: 32px;
    }

    .error-msg {
        color: #F53F3F;
        text-align: center;
        margin-bottom: 16px;
        font-size: 14px;
    }

    .success-msg {
        color: #00B42A;
        text-align: center;
        margin-bottom: 16px;
        font-size: 14px;
    }
</style>