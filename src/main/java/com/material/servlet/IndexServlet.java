package com.material.servlet;

import java.io.IOException;
import java.util.List;

import com.material.bean.Todo;
import com.material.bean.Notice;
import com.material.dao.TodoDao;
import com.material.dao.NoticeDao;
import com.material.dao.PurchaseApplyDao;
import com.material.dao.MaterialDao;
import com.material.dao.SysUserDao;
import com.material.dao.PurchaseTemplateDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/index")
public class IndexServlet extends HttpServlet {
	private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();
	private MaterialDao materialDao = new MaterialDao();
	private SysUserDao userDao = new SysUserDao();
	private PurchaseTemplateDao templateDao = new PurchaseTemplateDao();
	private TodoDao todoDao = new TodoDao();
	private NoticeDao noticeDao = new NoticeDao();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 原有统计数据
    	int userCount = userDao.countAll();
    	int templateCount = templateDao.countAll();
    	int materialCount = materialDao.countAll();
    	int purchaseCount = purchaseDao.countAllApply();
    	int completedCount = purchaseDao.countFinishApply();
        // 新增：待办事项和系统公告
        List<Todo> todoList = todoDao.listByRole("admin");
        List<Notice> noticeList = noticeDao.listAll();
        req.setAttribute("userCount", userCount);
        req.setAttribute("templateCount", templateCount);
        req.setAttribute("materialCount", materialCount);
        req.setAttribute("purchaseCount", purchaseCount);
        req.setAttribute("completedCount", completedCount);
        req.setAttribute("todoList", todoList);
        req.setAttribute("noticeList", noticeList);

        req.getRequestDispatcher("/admin/index.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doGet(req, res);
    }
}