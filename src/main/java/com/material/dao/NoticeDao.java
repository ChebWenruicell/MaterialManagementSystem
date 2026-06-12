package com.material.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.Notice;

public class NoticeDao {
    // 查询所有已发布和进行中的公告
    public List<Notice> listAll() {
        List<Notice> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
            String sql = "SELECT * FROM notice WHERE status='已发布' OR status='进行中' ORDER BY create_time DESC";
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notice n = new Notice();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("title"));
                n.setContent(rs.getString("content"));
                n.setStatus(rs.getString("status"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ 新增：发布公告
    public int add(Notice n) {
        try (Connection c = DBUtil.getConn()) {
            String sql = "INSERT INTO notice(title, content, status) VALUES(?,?,?)";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, n.getTitle());
            ps.setString(2, n.getContent());
            ps.setString(3, n.getStatus());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ✅ 新增：删除公告
    public int delete(int id) {
        try (Connection c = DBUtil.getConn()) {
            String sql = "DELETE FROM notice WHERE id=?";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}