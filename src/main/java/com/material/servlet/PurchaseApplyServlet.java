package com.material.servlet;

import com.material.dao.PurchaseTemplateDao;
import com.material.bean.PurchaseTemplate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/purchaser/purchaseApply")
public class PurchaseApplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PurchaseTemplateDao templateDao = new PurchaseTemplateDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PurchaseTemplate> templateList = templateDao.listAll();
        request.setAttribute("templateList", templateList);
        request.getRequestDispatcher("/purchaser/purchaseApply.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}