package com.material.servlet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.material.bean.PurchaseApply;
import com.material.bean.SysUser;
import com.material.dao.PurchaseApplyDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/purchaser/*")
public class PurchaseServlet extends HttpServlet{
    PurchaseApplyDao dao=new PurchaseApplyDao();

    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException{
        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");
        SysUser user=(SysUser)req.getSession().getAttribute("user");
        // 未登录拦截
        if(user == null){
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        String path=req.getPathInfo();
        // 1. 我的采购清单页面：查询当前用户所有采购单并转发页面
        if("/applyList".equals(path)){
            req.setAttribute("purchaseList", dao.selectByUser(user.getUsername()));
            req.getRequestDispatcher("/purchaser/myPurchase.jsp").forward(req,res);
        }
        // 2. AI一键生成采购单：自动填充数据存入数据库，跳转清单页
        else if("/aiCreate".equals(path)){
            PurchaseApply p=new PurchaseApply();
            // 生成唯一采购单号
            p.setPurchaseNo("CG"+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
            // AI默认采购数据，可自行修改
            p.setDept("行政部");
            p.setItem("办公耗材");
            p.setSpec("A4打印纸，5包装");
            p.setNum(5);
            p.setUsageDesc("日常办公文件打印、复印使用");
            p.setFilePath("");
            // 当前登录人为申请人
            p.setApplyUser(user.getUsername());
            // 插入数据库
            dao.add(p);
            // 生成完成自动跳转到我的采购列表
            res.sendRedirect(req.getContextPath()+"/purchaser/applyList");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException{
        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");
        String path=req.getPathInfo();
        SysUser user=(SysUser)req.getSession().getAttribute("user");
        if(user == null){
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        // 手动表单提交新增采购申请
        if("/add".equals(path)) {
            PurchaseApply p=new PurchaseApply();
            p.setPurchaseNo("CG"+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
            p.setDept(req.getParameter("dept"));
            p.setItem(req.getParameter("item"));
            p.setSpec(req.getParameter("spec"));
            p.setNum(Integer.parseInt(req.getParameter("num")));
            p.setUsageDesc(req.getParameter("usage"));
            p.setFilePath(req.getParameter("filePath"));
            p.setApplyUser(user.getUsername());
            // 数据写入数据库
            dao.add(p);
            // 提交完成跳转采购清单
            res.sendRedirect(req.getContextPath()+"/purchaser/applyList");
            return;
        }
    }
}