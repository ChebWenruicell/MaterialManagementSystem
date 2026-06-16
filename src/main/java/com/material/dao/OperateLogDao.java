package com.material.dao;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.OperateLog;

public class OperateLogDao {
    public int add(OperateLog log) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO operate_log(username,operate) VALUES(?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, log.getUsername());
            pstmt.setString(2, log.getOperate());
            res = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return res;
    }

    public List<OperateLog> list() {
        Connection conn = DBUtil.getConn();
        List<OperateLog> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM operate_log ORDER BY create_time DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                OperateLog log = new OperateLog();
                log.setId(rs.getInt("id"));
                log.setUsername(rs.getString("username"));
                log.setOperate(rs.getString("operate"));
                log.setCreateTime(rs.getTimestamp("create_time"));
                list.add(log);
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

    // 新增：操作人模糊 + 按日期筛选日志
    public List<OperateLog> listByFilter(String keyword, String logDate) {
        List<OperateLog> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
            StringBuilder sql = new StringBuilder("SELECT * FROM operate_log WHERE 1=1 ");
            List<Object> params = new ArrayList<>();

            // 操作人账号模糊匹配
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND username LIKE ? ");
                params.add("%" + keyword.trim() + "%");
            }
            // 按天筛选，匹配当天所有操作记录
            if (logDate != null && !logDate.trim().isEmpty()) {
                sql.append(" AND DATE(create_time) = ? ");
                params.add(Date.valueOf(logDate));
            }
            sql.append(" ORDER BY create_time DESC");

            PreparedStatement ps = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OperateLog log = new OperateLog();
                log.setId(rs.getInt("id"));
                log.setUsername(rs.getString("username"));
                log.setOperate(rs.getString("operate"));
                log.setCreateTime(rs.getTimestamp("create_time"));
                list.add(log);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}