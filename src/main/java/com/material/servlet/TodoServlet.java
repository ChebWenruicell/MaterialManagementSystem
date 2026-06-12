package com.material.servlet;

import java.io.IOException;
import java.util.List;

import com.material.bean.Todo;
import com.material.dao.TodoDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/todo/*")
public class TodoServlet extends HttpServlet {
    private TodoDao todoDao = new TodoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            // 待办列表
            List<Todo> todoList = todoDao.listByRole("all");
            req.setAttribute("todoList", todoList);
            // ✅ 修正转发路径：前面加了 /
            req.getRequestDispatcher("/admin/todoManage.jsp").forward(req, res);
        } else if (path.equals("/complete")) {
            // 标记完成
            int id = Integer.parseInt(req.getParameter("id"));
            todoDao.complete(id);
            // ✅ 修正重定向拼接
            res.sendRedirect(req.getContextPath() + "/admin/todo");
        } else if (path.equals("/delete")) {
            // 删除待办
            int id = Integer.parseInt(req.getParameter("id"));
            todoDao.delete(id);
            // ✅ 修正重定向拼接
            res.sendRedirect(req.getContextPath() + "/admin/todo");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 添加待办
        String content = req.getParameter("content");
        String role = req.getParameter("role");
        
        Todo todo = new Todo();
        todo.setContent(content);
        todo.setRole(role);
        
        todoDao.add(todo);
        res.sendRedirect(req.getContextPath() + "/admin/todo");
    }
}