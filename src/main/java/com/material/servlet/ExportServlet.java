package com.material.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import com.material.dao.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/export")
public class ExportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        String type = request.getParameter("type");
        
        String fileName = "export.xls";
        String sql = "";
        
        if ("user".equals(type)) {
            fileName = "用户列表.xls";
            sql = "SELECT id,username,real_name,role,phone,email FROM sys_user";
        } else if ("material".equals(type)) {
            fileName = "物资列表.xls";
            sql = "SELECT id,material_name,spec,price,unit FROM material";
        } else if ("apply".equals(type)) {
            fileName = "采购申请单.xls";
            sql = "SELECT id,purchase_no,dept,item,spec,num,usage_desc,apply_user,status FROM purchase_apply";
        } else if ("log".equals(type)) {
            fileName = "操作日志.xls";
            sql = "SELECT id,username,operate,create_time FROM operate_log";
        }

        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
        OutputStream out = response.getOutputStream();

        try (Connection conn = DBUtil.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            ResultSetMetaData meta = rs.getMetaData();
            int col = meta.getColumnCount();

            // 写表头
            for (int i = 1; i <= col; i++) {
                out.write((meta.getColumnName(i) + "\t").getBytes("UTF-8"));
            }
            out.write(("\n").getBytes());

            // 写数据
            while (rs.next()) {
                for (int i = 1; i <= col; i++) {
                    String val = rs.getString(i) == null ? "" : rs.getString(i);
                    out.write((val + "\t").getBytes("UTF-8"));
                }
                out.write(("\n").getBytes());
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}