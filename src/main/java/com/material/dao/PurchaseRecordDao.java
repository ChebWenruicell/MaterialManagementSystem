package com.material.dao;

import com.material.bean.PurchaseRecord;
// 改这里：DBUtil和当前Dao同包com.material.dao，直接导入
import com.material.dao.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Date;

public class PurchaseRecordDao {
    // 新增采购申请记录
    public int add(PurchaseRecord record){
        Connection conn = null;
        PreparedStatement pstmt = null;
        int res = 0;
        try {
            conn = DBUtil.getConn();
            String sql = "INSERT INTO purchase_record(dept,item,spec,num,usage,create_time,status) VALUES(?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, record.getDept());
            pstmt.setString(2, record.getItem());
            pstmt.setString(3, record.getSpec());
            pstmt.setInt(4, record.getNum());
            pstmt.setString(5, record.getUsage());
            pstmt.setTimestamp(6, new Timestamp(new Date().getTime()));
            pstmt.setInt(7, 0); // 0=待审核
            res = pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            // 分步关闭，你的DBUtil没有三参close方法，不能调用DBUtil.close
            try{
                if(pstmt != null) pstmt.close();
            }catch(Exception e){}
            try{
                if(conn != null) conn.close();
            }catch(Exception e){}
        }
        return res;
    }
}