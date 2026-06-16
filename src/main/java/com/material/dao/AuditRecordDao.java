package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.AuditRecord;

public class AuditRecordDao {
    public int add(AuditRecord ar) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO audit_record(purchase_id,purchase_no,audit_result,audit_reason,audit_user) VALUES(?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ar.getPurchaseId());
            pstmt.setString(2, ar.getPurchaseNo());
            pstmt.setString(3, ar.getAuditResult());
            pstmt.setString(4, ar.getAuditReason());
            pstmt.setString(5, ar.getAuditUser());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    // 按审批人查询审批记录
    public List<AuditRecord> listByApprover(String username) {
        Connection conn = DBUtil.getConn();
        List<AuditRecord> list = new ArrayList<>();
        try {
            String sql = "select * from audit_record where audit_user=? order by audit_time desc";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                AuditRecord ar = new AuditRecord();
                ar.setId(rs.getInt("id"));
                ar.setPurchaseId(rs.getInt("purchase_id"));
                ar.setPurchaseNo(rs.getString("purchase_no"));
                ar.setAuditResult(rs.getString("audit_result"));
                ar.setAuditReason(rs.getString("audit_reason"));
                ar.setAuditUser(rs.getString("audit_user"));
                // 修复点：数据库时间转Date，解决类型不匹配报错
                Timestamp ts = rs.getTimestamp("audit_time");
                if(ts != null){
                    ar.setAuditTime(new java.util.Date(ts.getTime()));
                }
                list.add(ar);
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return list;
    }
}