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
        // 接收页面两个筛选参数
        String keyword = request.getParameter("keyword");
        String logDate = request.getParameter("logDate");
        // 调用多条件过滤方法
        List<OperateLog> logList = logDao.listByFilter(keyword, logDate);

        // 传给页面列表 + 回填筛选条件
        request.setAttribute("logList", logList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("logDate", logDate);
        request.getRequestDispatcher("/admin/operateLog.jsp").forward(request, response);
    }
}