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

    // ✅ 只加这3行：解决405错误，让GET请求也能正常访问
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    // ✅ 只给方法加了throws，你原来的代码一行没动
    protected void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
        try{
            req.setCharacterEncoding("utf8");
            String path=req.getPathInfo();
            SysUser user=(SysUser)req.getSession().getAttribute("user");

            // ✅ 只加了这一个if分支：实现采购记录列表
            if(path.equals("/listAll")) {
                List<PurchaseApply> purchaseList = dao.listAll();
                req.setAttribute("purchaseList", purchaseList);
                req.getRequestDispatcher("/admin/purchaseRecord.jsp").forward(req, res);
            }

            // ✅ 你原来的/add代码，完全没动
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