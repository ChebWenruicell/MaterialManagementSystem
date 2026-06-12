package com.material.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.Todo;

public class TodoDao {
    // 根据角色查询待办事项（只查待处理的）
    public List<Todo> listByRole(String role) {
        List<Todo> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
            String sql = "SELECT * FROM todo WHERE (role=? OR role='all') AND status='待处理' ORDER BY create_time DESC";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Todo t = new Todo();
                t.setId(rs.getInt("id"));
                t.setContent(rs.getString("content"));
                t.setRole(rs.getString("role"));
                t.setStatus(rs.getString("status"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ 新增：添加待办事项
    public int add(Todo t) {
        try (Connection c = DBUtil.getConn()) {
            String sql = "INSERT INTO todo(content, role) VALUES(?,?)";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, t.getContent());
            ps.setString(2, t.getRole());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ✅ 新增：标记待办为已完成
    public int complete(int id) {
        try (Connection c = DBUtil.getConn()) {
            String sql = "UPDATE todo SET status='已完成' WHERE id=?";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ✅ 新增：删除待办事项
    public int delete(int id) {
        try (Connection c = DBUtil.getConn()) {
            String sql = "DELETE FROM todo WHERE id=?";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}