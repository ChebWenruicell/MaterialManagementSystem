package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.Material;
public class MaterialDao {
    public List<Material> list() {
        Connection conn = DBUtil.getConn();
        List<Material> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM material";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Material m = new Material();
                m.setId(rs.getInt("id"));
                m.setMaterialName(rs.getString("material_name"));
                m.setSpec(rs.getString("spec"));
                m.setPrice(rs.getDouble("price"));
                m.setUnit(rs.getString("unit"));
                list.add(m);
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
    public int add(Material m) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO material(material_name,spec,price,unit) VALUES(?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, m.getMaterialName());
            pstmt.setString(2, m.getSpec());
            pstmt.setDouble(3, m.getPrice());
            pstmt.setString(4, m.getUnit());
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
