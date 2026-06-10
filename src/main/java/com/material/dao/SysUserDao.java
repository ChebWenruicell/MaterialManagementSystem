package com.material.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.SysUser;
import java.security.MessageDigest; // 新增：MD5加密需要的包

public class SysUserDao {
    // ✅ 新增：MD5加密方法（匹配数据库里的加密密码）
    private String md5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) sb.append('0');
                sb.append(hex);
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public SysUser login(String username, String password) {
        Connection conn = DBUtil.getConn();
        SysUser user = null;
        try {
            // ✅ 对输入的密码进行MD5加密，再和数据库对比
            String encryptedPassword = md5(password);
            
            String sql = "SELECT * FROM sys_user WHERE username=? AND password=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, encryptedPassword); // ✅ 用加密后的密码查询
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

    // 下面的list()、add()、delete()、update()方法都不用改！
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
            // ✅ 新增用户时也自动加密密码
            String sql = "INSERT INTO sys_user(username,password,real_name,role,phone,email) VALUES(?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getUsername());
            pstmt.setString(2, md5(u.getPassword())); // ✅ 加密后再存入数据库
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
            // ✅ 修改用户时，如果密码不为空就加密，为空则不修改密码
            String sql;
            if (u.getPassword() != null && !u.getPassword().isEmpty()) {
                sql = "update sys_user set username=?,password=?,real_name=?,role=?,phone=?,email=? where id=?";
            } else {
                sql = "update sys_user set username=?,real_name=?,role=?,phone=?,email=? where id=?";
            }
            PreparedStatement p=conn.prepareStatement(sql);
            p.setString(1,u.getUsername());
            int index = 2;
            if (u.getPassword() != null && !u.getPassword().isEmpty()) {
                p.setString(index++, md5(u.getPassword()));
            }
            p.setString(index++,u.getRealName());
            p.setString(index++,u.getRole());
            p.setString(index++,u.getPhone());
            p.setString(index++,u.getEmail());
            p.setInt(index,u.getId());
            r=p.executeUpdate();
            p.close();
        }catch(Exception e){e.printStackTrace();}
        finally{try{conn.close();}catch(Exception e){}}
        return r;
    }
}