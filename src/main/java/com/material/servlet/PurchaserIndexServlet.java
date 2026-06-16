package com.material.servlet;

import com.material.bean.SysUser;
import com.material.dao.TodoDao;
import com.material.dao.NoticeDao;
import com.material.dao.PurchaseApplyDao;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/purchaser/index")
public class PurchaserIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TodoDao todoDao = new TodoDao();
    private NoticeDao noticeDao = new NoticeDao();
    // 新增采购单Dao
    private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 权限校验：未登录或角色不符直接跳登录页
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        if (user == null || !"采购人".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String username = user.getUsername();

        // 原有逻辑：待办、公告
        request.setAttribute("todoList", todoDao.listByRole("采购人"));
        request.setAttribute("noticeList", noticeDao.listAll());

        // 新增：查询当前采购人三类单据数量
        int myPurchaseCount = purchaseDao.countByUser(username);
        int pendingCount = purchaseDao.countWaitByUser(username);
        int completedCount = purchaseDao.countFinishByUser(username);

        // 传给页面EL表达式
        request.setAttribute("myPurchaseCount", myPurchaseCount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("completedCount", completedCount);

        // 转发到 JSP 页面渲染
        request.getRequestDispatcher("/purchaser/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}