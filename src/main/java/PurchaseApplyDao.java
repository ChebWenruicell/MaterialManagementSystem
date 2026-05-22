
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.PurchaseApply;
import com.material.dao.DBUtil;
public class PurchaseApplyDao {
    public int add(PurchaseApply p) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO purchase_apply(purchase_no,dept,item,spec,num,usage_desc,file_path,apply_user) VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, p.getPurchaseNo());
            pstmt.setString(2, p.getDept());
            pstmt.setString(3, p.getItem());
            pstmt.setString(4, p.getSpec());
            pstmt.setInt(5, p.getNum());
            pstmt.setString(6, p.getUsageDesc());
            pstmt.setString(7, p.getFilePath());
            pstmt.setString(8, p.getApplyUser());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }
    public List<PurchaseApply> listByUser(String applyUser) {
        Connection conn = DBUtil.getConn();
        List<PurchaseApply> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM purchase_apply WHERE apply_user=? ORDER BY create_time DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, applyUser);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PurchaseApply p = new PurchaseApply();
                p.setId(rs.getInt("id"));
                p.setPurchaseNo(rs.getString("purchase_no"));
                p.setDept(rs.getString("dept"));
                p.setItem(rs.getString("item"));
                p.setSpec(rs.getString("spec"));
                p.setNum(rs.getInt("num"));
                p.setStatus(rs.getString("status"));
                p.setCreateTime(rs.getTimestamp("create_time"));
                list.add(p);
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
    public List<PurchaseApply> listWaitAudit() {
        Connection conn = DBUtil.getConn();
        List<PurchaseApply> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM purchase_apply WHERE status='待审核' ORDER BY create_time DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PurchaseApply p = new PurchaseApply();
                p.setId(rs.getInt("id"));
                p.setPurchaseNo(rs.getString("purchase_no"));
                p.setDept(rs.getString("dept"));
                p.setItem(rs.getString("item"));
                p.setStatus(rs.getString("status"));
                list.add(p);
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
    public int updateStatus(Integer id, String status) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "UPDATE purchase_apply SET status=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
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
