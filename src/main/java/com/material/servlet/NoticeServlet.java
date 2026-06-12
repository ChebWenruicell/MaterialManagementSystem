package com.material.servlet;

import java.io.IOException;
import java.util.List;

import com.material.bean.Notice;
import com.material.dao.NoticeDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/notice/*")
public class NoticeServlet extends HttpServlet {
    private NoticeDao noticeDao = new NoticeDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            // 公告列表
            List<Notice> noticeList = noticeDao.listAll();
            req.setAttribute("noticeList", noticeList);
            req.getRequestDispatcher("/admin/noticeManage.jsp").forward(req, res);
        } else if (path.equals("/delete")) {
            // 删除公告
            int id = Integer.parseInt(req.getParameter("id"));
            noticeDao.delete(id);
            res.sendRedirect(req.getContextPath() + "/admin/notice");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 添加公告
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String status = req.getParameter("status");
        
        Notice notice = new Notice();
        notice.setTitle(title);
        notice.setContent(content);
        notice.setStatus(status);
        
        noticeDao.add(notice);
        res.sendRedirect(req.getContextPath() + "/admin/notice");
    }
}