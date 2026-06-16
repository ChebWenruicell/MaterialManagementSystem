package com.material.dao;

import com.material.bean.Todo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TodoDao {

    // 根据角色查询待处理待办（首页使用）
    public List<Todo> listByRole(String role) {
        List<Todo> list = new ArrayList<>();
        String sql = "SELECT * FROM todo WHERE (role = ? OR role = 'all') AND status = '待处理' ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, role);
            // ResultSet 放入 try-with-resources，使用后自动关闭
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Todo todo = new Todo();
                    todo.setId(rs.getInt("id"));
                    todo.setContent(rs.getString("content"));
                    todo.setRole(rs.getString("role"));
                    todo.setStatus(rs.getString("status"));
                    todo.setCreateTime(rs.getString("create_time"));
                    list.add(todo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 查询全部待办（管理页使用）
    public List<Todo> listAll() {
        List<Todo> list = new ArrayList<>();
        String sql = "SELECT * FROM todo ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Todo todo = new Todo();
                todo.setId(rs.getInt("id"));
                todo.setContent(rs.getString("content"));
                todo.setRole(rs.getString("role"));
                todo.setStatus(rs.getString("status"));
                todo.setCreateTime(rs.getString("create_time"));
                list.add(todo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 新增待办
    public int add(Todo todo) {
        String sql = "INSERT INTO todo(content, role, status, create_time) VALUES(?,?,?,NOW())";
        
        try (Connection conn = DBUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, todo.getContent());
            ps.setString(2, todo.getRole());
            ps.setString(3, "待处理");
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 标记为已完成
    public int complete(int id) {
        String sql = "UPDATE todo SET status = '已完成' WHERE id = ?";
        
        try (Connection conn = DBUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 删除待办
    public int delete(int id) {
        String sql = "DELETE FROM todo WHERE id = ?";
        
        try (Connection conn = DBUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}