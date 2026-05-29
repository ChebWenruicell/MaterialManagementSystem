
package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
}