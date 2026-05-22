package com.material.servlet;
import com.material.bean.AuditRecord;
import com.material.bean.SysUser;
import com.material.dao.AuditRecordDao;
import com.material.dao.PurchaseApplyDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/audit/*")
public class AuditServlet extends HttpServlet{
    protected void doPost(HttpServletRequest req,HttpServletResponse res){
        try{
            req.setCharacterEncoding("utf8");
            SysUser user=(SysUser)req.getSession().getAttribute("user");
            int pid=Integer.parseInt(req.getParameter("id"));
            String no=req.getParameter("no");
            String result=req.getParameter("result");
            String reason=req.getParameter("reason");
            
            AuditRecord ar=new AuditRecord();
            ar.setPurchaseId(pid); ar.setPurchaseNo(no);
            ar.setAuditResult(result); ar.setAuditReason(reason);
            ar.setAuditUser(user.getUsername());
            new AuditRecordDao().add(ar);
            new PurchaseApplyDao().updateStatus(pid,result);
            res.sendRedirect("auditList.jsp");
        }catch(Exception e){e.printStackTrace();}
    }
}
