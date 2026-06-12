package com.material.servlet;
import java.io.IOException;
import java.util.List;
import com.material.bean.OperateLog;
import com.material.dao.OperateLogDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/log/list")
public class LogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OperateLogDao logDao = new OperateLogDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<OperateLog> list = logDao.list();
        request.setAttribute("logList", list);
        // ✅ 只改这一行：把 logList.jsp 改成 operateLog.jsp
        request.getRequestDispatcher("/admin/operateLog.jsp").forward(request, response);
    }
}