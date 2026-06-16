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
        // 登录+审批人权限校验 完全保留
        if(user == null || !"审批人".equals(user.getRole())){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 新增：接收页面搜索关键词
        String keyword = request.getParameter("keyword");
        // 替换原listWait()，调用带筛选的方法
        List<PurchaseApply> pendingList = purchaseDao.listWaitByKeyword(keyword);

        request.setAttribute("pendingList", pendingList);
        // 把关键词传回页面，搜索框自动回填
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/approver/auditList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}