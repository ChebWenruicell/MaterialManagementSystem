package com.material.servlet;

import com.material.bean.PurchaseRecord;
import com.material.dao.PurchaseRecordDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/purchase/submit")
public class PurchaseSubmitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PurchaseRecordDao recordDao = new PurchaseRecordDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String dept = request.getParameter("dept");
        String item = request.getParameter("item");
        String spec = request.getParameter("spec");
        String numStr = request.getParameter("num");
        String usage = request.getParameter("usage");

        // 判空处理，防止null转换报错
        int num = 1; // 默认值1
        if(numStr != null && !numStr.trim().isEmpty()){
            num = Integer.parseInt(numStr.trim());
        }

        PurchaseRecord record = new PurchaseRecord();
        record.setDept(dept);
        record.setItem(item);
        record.setSpec(spec);
        record.setNum(num);
        record.setUsage(usage);

        int effectRows = recordDao.add(record);

        if(effectRows > 0){
            response.sendRedirect(request.getContextPath() + "/purchaser/index");
        }else{
            response.getWriter().write("提交失败，数据未保存！<br><a href='javascript:history.back()'>返回填写页面</a>");
        }
    }
}