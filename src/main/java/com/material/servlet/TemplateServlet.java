package com.material.servlet;

import java.io.IOException;
import java.util.List;

import com.material.bean.OperateLog;
import com.material.bean.PurchaseTemplate;
import com.material.bean.SysUser;
import com.material.dao.OperateLogDao;
import com.material.dao.PurchaseTemplateDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/template/*")
public class TemplateServlet extends HttpServlet {
    private PurchaseTemplateDao templateDao = new PurchaseTemplateDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        SysUser loginUser = (SysUser) session.getAttribute("user");

        // 列表查询
        if("/list".equals(path)){
            List<PurchaseTemplate> list = templateDao.list();
            request.setAttribute("templateList",list);
            request.getRequestDispatcher("/admin/templateConfig.jsp").forward(request,response);
        }
        //新增
        else if("/add".equals(path)){
            String tName = request.getParameter("templateName");
            String field = request.getParameter("fieldList");
            String reqField = request.getParameter("requiredList");
            Integer status = Integer.parseInt(request.getParameter("status"));

            PurchaseTemplate pt = new PurchaseTemplate();
            pt.setTemplateName(tName);
            pt.setFieldList(field);
            pt.setRequiredList(reqField);
            pt.setStatus(status);
            templateDao.add(pt);

            //操作日志
            String op = loginUser==null?"系统":loginUser.getUsername();
            new OperateLogDao().add(new OperateLog(op,"新增模板："+tName));
            response.sendRedirect("list");
        }
        //删除
        else if("/delete".equals(path)){
            Integer id = Integer.parseInt(request.getParameter("id"));
            templateDao.delete(id);
            String op = loginUser==null?"系统":loginUser.getUsername();
            new OperateLogDao().add(new OperateLog(op,"删除模板ID："+id));
            response.sendRedirect("list");
        }
        //修改
        else if("/update".equals(path)){
            Integer id = Integer.parseInt(request.getParameter("id"));
            String tName = request.getParameter("templateName");
            String field = request.getParameter("fieldList");
            String reqField = request.getParameter("requiredList");
            Integer status = Integer.parseInt(request.getParameter("status"));

            PurchaseTemplate pt = new PurchaseTemplate();
            pt.setId(id);
            pt.setTemplateName(tName);
            pt.setFieldList(field);
            pt.setRequiredList(reqField);
            pt.setStatus(status);
            templateDao.update(pt);

            String op = loginUser==null?"系统":loginUser.getUsername();
            new OperateLogDao().add(new OperateLog(op,"修改模板ID："+id));
            response.sendRedirect("list");
        }
    }
}