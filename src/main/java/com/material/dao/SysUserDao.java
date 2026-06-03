package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.SysUser;

public class SysUserDao {
    public SysUser login(String username, String password) {
        Connection conn = DBUtil.getConn();
        SysUser user = null;
        try {
            String sql = "SELECT * FROM sys_user WHERE username=? AND password=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new SysUser();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRealName(rs.getString("real_name"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return user;
    }

    // 已修复：添加了email赋值
    public List<SysUser> list() {
        Connection conn = DBUtil.getConn();
        List<SysUser> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM sys_user";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                SysUser u = new SysUser();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setRealName(rs.getString("real_name"));
                u.setRole(rs.getString("role"));
                u.setPhone(rs.getString("phone"));
                u.setEmail(rs.getString("email"));
                list.add(u);
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

    public int add(SysUser u) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO sys_user(username,password,real_name,role,phone,email) VALUES(?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getUsername());
            pstmt.setString(2, u.getPassword());
            pstmt.setString(3, u.getRealName());
            pstmt.setString(4, u.getRole());
            pstmt.setString(5, u.getPhone());
            pstmt.setString(6, u.getEmail());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    public int delete(Integer id) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "DELETE FROM sys_user WHERE id=?";
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
    public int update(SysUser u){
        Connection conn=DBUtil.getConn();
        int r=0;
        try{
            String sql="update sys_user set username=?,real_name=?,role=?,phone=?,email=? where id=?";
            PreparedStatement p=conn.prepareStatement(sql);
            p.setString(1,u.getUsername());
            p.setString(2,u.getRealName());
            p.setString(3,u.getRole());
            p.setString(4,u.getPhone());
            p.setString(5,u.getEmail());
            p.setInt(6,u.getId());
            r=p.executeUpdate();
            p.close();
        }catch(Exception e){e.printStackTrace();}
        finally{try{conn.close();}catch(Exception e){}}
        return r;
    }
}