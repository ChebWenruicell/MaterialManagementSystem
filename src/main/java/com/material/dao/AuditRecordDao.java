package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.AuditRecord;
import com.material.bean.PurchaseApply;

public class AuditRecordDao {
    private PurchaseApplyDao purchaseDao = new PurchaseApplyDao();

    // 新增审批记录：自动根据purchaseId查询采购单号填入，不用前端传
    public int add(AuditRecord ar) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int res = 0;
        try {
            conn = DBUtil.getConn();
            // 自动查询采购单号回填
            PurchaseApply apply = purchaseDao.getById(ar.getPurchaseId());
            if(apply != null){
                ar.setPurchaseNo(apply.getPurchaseNo());
            }
            String sql = "INSERT INTO audit_record(purchase_id,purchase_no,audit_result,audit_reason,audit_user,audit_time) VALUES(?,?,?,?,?,NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ar.getPurchaseId());
            pstmt.setString(2, ar.getPurchaseNo());
            pstmt.setString(3, ar.getAuditResult());
            pstmt.setString(4, ar.getAuditReason());
            pstmt.setString(5, ar.getAuditUser());
            res = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if(conn != null) conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    // 按审批人查询审批记录
    public List<AuditRecord> listByApprover(String username) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<AuditRecord> list = new ArrayList<>();
        try {
            conn = DBUtil.getConn();
            String sql = "select * from audit_record where audit_user=? order by audit_time desc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                AuditRecord ar = new AuditRecord();
                ar.setId(rs.getInt("id"));
                ar.setPurchaseId(rs.getInt("purchase_id"));
                ar.setPurchaseNo(rs.getString("purchase_no"));
                ar.setAuditResult(rs.getString("audit_result"));
                ar.setAuditReason(rs.getString("audit_reason"));
                ar.setAuditUser(rs.getString("audit_user"));
                Timestamp ts = rs.getTimestamp("audit_time");
                if(ts != null){
                    ar.setAuditTime(new java.util.Date(ts.getTime()));
                }
                list.add(ar);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch (Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if(conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }
}