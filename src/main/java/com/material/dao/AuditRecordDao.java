package com.material.dao;
import java.sql.Connection;
import java.sql.Date;
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

    // 新增多条件筛选：审批人 + 采购单号模糊 + 审批结果 + 审批日期
    public List<AuditRecord> listByFilter(String approver, String keyword, String auditResult, String auditDate) {
        List<AuditRecord> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            StringBuilder sql = new StringBuilder("SELECT * FROM audit_record WHERE audit_user = ? ");
            List<Object> params = new ArrayList<>();
            params.add(approver);

            // 采购单号模糊匹配
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND purchase_no LIKE ? ");
                params.add("%" + keyword.trim() + "%");
            }
            // 审批结果筛选：通过/驳回
            if (auditResult != null && !auditResult.trim().isEmpty()) {
                sql.append(" AND audit_result = ? ");
                params.add(auditResult.trim());
            }
            // 按审批日期筛选当天记录
            if (auditDate != null && !auditDate.trim().isEmpty()) {
                sql.append(" AND DATE(audit_time) = ? ");
                params.add(Date.valueOf(auditDate));
            }
            sql.append(" ORDER BY audit_time DESC");

            pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
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
                if (ts != null) {
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