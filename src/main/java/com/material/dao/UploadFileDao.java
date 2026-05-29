
package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.material.bean.UploadFile;
public class UploadFileDao {
    public int add(UploadFile uf) {
        Connection conn = DBUtil.getConn();
        int res = 0;
        try {
            String sql = "INSERT INTO upload_file(file_name,file_path,file_type,upload_user) VALUES(?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, uf.getFileName());
            pstmt.setString(2, uf.getFilePath());
            pstmt.setString(3, uf.getFileType());
            pstmt.setString(4, uf.getUploadUser());
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