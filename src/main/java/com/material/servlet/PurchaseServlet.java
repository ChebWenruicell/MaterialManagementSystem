
package com.material.servlet;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.material.bean.PurchaseApply;
import com.material.bean.SysUser;
import com.material.dao.PurchaseApplyDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/purchase/*")
public class PurchaseServlet extends HttpServlet{
    PurchaseApplyDao dao=new PurchaseApplyDao();
    protected void doPost(HttpServletRequest req,HttpServletResponse res){
        try{
            req.setCharacterEncoding("utf8");
            String path=req.getPathInfo();
            SysUser user=(SysUser)req.getSession().getAttribute("user");
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
