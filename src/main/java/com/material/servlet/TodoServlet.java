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
            // 待办管理页面：查询全部待办，改用listAll()
            List<Todo> todoList = todoDao.listAll();
            req.setAttribute("todoList", todoList);
            req.getRequestDispatcher("/admin/todoManage.jsp").forward(req, res);
        } else if (path.equals("/complete")) {
            // 标记待办为完成
            int id = Integer.parseInt(req.getParameter("id"));
            todoDao.complete(id);
            res.sendRedirect(req.getContextPath() + "/admin/todo");
        } else if (path.equals("/delete")) {
            // 删除待办
            int id = Integer.parseInt(req.getParameter("id"));
            todoDao.delete(id);
            res.sendRedirect(req.getContextPath() + "/admin/todo");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 新增待办提交
        String content = req.getParameter("content");
        String role = req.getParameter("role");
        
        Todo todo = new Todo();
        todo.setContent(content);
        todo.setRole(role);
        
        todoDao.add(todo);
        res.sendRedirect(req.getContextPath() + "/admin/todo");
    }
}