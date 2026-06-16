package com.material.servlet;

import com.material.bean.PurchaseApply;
import com.material.bean.SysUser;
import com.material.dao.PurchaseApplyDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/approver/auditList")
public class AuditListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        // 登录+审批人权限校验
        if(user == null || !"审批人".equals(user.getRole())){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        // 查询全部待审核单据
        List<PurchaseApply> pendingList = purchaseDao.listWait();
        request.setAttribute("pendingList", pendingList);
        // 转发到 auditList.jsp
        request.getRequestDispatcher("/approver/auditList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}