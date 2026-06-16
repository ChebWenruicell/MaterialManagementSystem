package com.material.servlet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import com.material.bean.PurchaseApply;
import com.material.bean.SysUser;
import com.material.dao.PurchaseApplyDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/purchase/*")
public class PurchaseServlet extends HttpServlet{
    PurchaseApplyDao dao=new PurchaseApplyDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    protected void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
        try{
            req.setCharacterEncoding("utf8");
            String path=req.getPathInfo();
            SysUser user=(SysUser)req.getSession().getAttribute("user");

            if(path.equals("/listAll")) {
                // 接收页面筛选参数
                String keyword = req.getParameter("keyword");
                String status = req.getParameter("status");
                // 多条件过滤查询
                List<PurchaseApply> purchaseList = dao.listByFilter(keyword, status);
                // 传给页面列表、回填筛选条件
                req.setAttribute("purchaseList", purchaseList);
                req.setAttribute("keyword", keyword);
                req.setAttribute("status", status);
                req.getRequestDispatcher("/admin/purchaseRecord.jsp").forward(req, res);
            }

            if(path.equals("/add")) {
                PurchaseApply p=new PurchaseApply();
                p.setPurchaseNo("CG"+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
                p.setDept(req.getParameter("dept"));
                p.setItem(req.getParameter("item"));
                p.setSpec(req.getParameter("spec"));
                p.setNum(Integer.parseInt(req.getParameter("num")));
                p.setUsageDesc(req.getParameter("usageDesc"));
                p.setFilePath(req.getParameter("filePath"));
                p.setApplyUser(user.getUsername());
                dao.add(p);
                res.sendRedirect("applyList.jsp");
            }
        }catch(Exception e){e.printStackTrace();}
    }
}