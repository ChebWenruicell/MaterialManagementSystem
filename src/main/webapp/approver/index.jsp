<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 对应Servlet地址：/approver/index -->
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>审批人工作台</title>
    <style>
        
        .stat-card {
            cursor: pointer;
            transition: all 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }
    </style>
</head>
<body>
    <%@ include file="../common/sidebar_approver.jsp" %>
    <div class="main-content">
        <h1 class="page-title">审批人工作台</h1>
        
        <!-- 快捷操作区 -->
        <div class="quick-actions" style="grid-template-columns: repeat(3, 1fr);">
            <a href="${pageContext.request.contextPath}/approver/auditList" class="quick-action-btn">
                <div class="quick-action-icon">✓</div>
                <span>待审核采购单</span>
            </a>
            <a href="${pageContext.request.contextPath}/approver/auditRecord" class="quick-action-btn">
                <div class="quick-action-icon">☰</div>
                <span>我的审批记录</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/purchaseRecord.jsp" class="quick-action-btn">
                <div class="quick-action-icon">📊</div>
                <span>全部采购记录</span>
            </a>
        </div>
        
        <!-- 数据统计区（现在可点击跳转） -->
        <div class="row">
            <div class="col-4">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/approver/auditList'">
                    <div class="stat-icon stat-icon-orange">⏳</div>
                    <div class="stat-number">${pendingCount}</div>
                    <div class="stat-label">待审核采购单</div>
                </div>
            </div>
            <div class="col-4">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/approver/auditRecord'">
                    <div class="stat-icon stat-icon-green">✅</div>
                    <div class="stat-number">${approvedCount}</div>
                    <div class="stat-label">已通过</div>
                </div>
            </div>
            <div class="col-4">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/approver/auditRecord'">
                    <div class="stat-icon stat-icon-red">❌</div>
                    <div class="stat-number">${rejectedCount}</div>
                    <div class="stat-label">已驳回</div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">待审核列表（最近5条）</h3>
                <a href="${pageContext.request.contextPath}/approver/auditList" class="btn btn-primary btn-sm">立即审核</a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>采购单号</th>
                        <th>申请部门</th>
                        <th>申请人</th>
                        <th>申请时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pendingList}" var="purchase" begin="0" end="4">
                        <tr>
                            <td>${purchase.purchaseNo}</td>
                            <td>${purchase.dept}</td>
                            <td>${purchase.applyUser}</td>
                            <td>${purchase.createTime}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/approver/auditDetail?purchaseId=${purchase.id}" class="btn btn-primary btn-sm">审核</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingList}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">
                                🎉 暂无待审核采购单
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>