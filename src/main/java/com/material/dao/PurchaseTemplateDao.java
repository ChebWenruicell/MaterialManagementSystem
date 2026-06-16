package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.PurchaseTemplate;
public class PurchaseTemplateDao {
    public List<PurchaseTemplate> list() {
        Connection conn = DBUtil.getConn();
        List<PurchaseTemplate> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM purchase_template";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PurchaseTemplate t = new PurchaseTemplate();
                t.setId(rs.getInt("id"));
                t.setTemplateName(rs.getString("template_name"));
                t.setFieldList(rs.getString("field_list"));
                t.setRequiredList(rs.getString("required_list"));
                t.setStatus(rs.getInt("status"));
                t.setCreateTime(rs.getTimestamp("create_time"));
                list.add(t);
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
    public int add(PurchaseTemplate t) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO purchase_template(template_name,field_list,required_list,status) VALUES(?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, t.getTemplateName());
            pstmt.setString(2, t.getFieldList());
            pstmt.setString(3, t.getRequiredList());
            pstmt.setInt(4, t.getStatus());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }
    // 删除模板
    public int delete(Integer id) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "DELETE FROM purchase_template WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    // 修改模板
    public int update(PurchaseTemplate t) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "UPDATE purchase_template SET template_name=?,field_list=?,required_list=?,status=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, t.getTemplateName());
            pstmt.setString(2, t.getFieldList());
            pstmt.setString(3, t.getRequiredList());
            pstmt.setInt(4, t.getStatus());
            pstmt.setInt(5, t.getId());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    // 仅新增统计模板总数，放在类最外层，不在任何方法内部
    public int countAll() {
        Connection conn = DBUtil.getConn();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM purchase_template";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if(rs != null) rs.close();}catch(Exception e){}
            try {if(pstmt != null) pstmt.close();}catch(Exception e){}
            try {if(conn != null) conn.close();}catch(Exception e){}
        }
        return 0;
    }
}