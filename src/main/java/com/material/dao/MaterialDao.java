package com.material.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.Material;
import com.material.dao.DBUtil;

public class MaterialDao {

    public List<Material> list() {
        Connection conn = DBUtil.getConn();
        List<Material> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM material";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Material t = new Material();
                t.setId(rs.getInt("id"));
                t.setMaterialName(rs.getString("material_name"));
                t.setSpec(rs.getString("spec"));
                t.setPrice(rs.getDouble("price"));
                t.setUnit(rs.getString("unit"));
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

    // ================== 新增：修改 ==================
    public int update(Material m) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "UPDATE material SET material_name=?, spec=?, price=?, unit=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, m.getMaterialName());
            pstmt.setString(2, m.getSpec());
            pstmt.setDouble(3, m.getPrice());
            pstmt.setString(4, m.getUnit());
            pstmt.setInt(5, m.getId());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    // ================== 新增：删除 ==================
    public int delete(Integer id) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "DELETE FROM material WHERE id=?";
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

    // ✅ 只加了这一个方法：查询物资种类总数
    public int countAll() {
        Connection conn = DBUtil.getConn();
        try {
            String sql = "SELECT COUNT(*) FROM material";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return 0;
    }
}