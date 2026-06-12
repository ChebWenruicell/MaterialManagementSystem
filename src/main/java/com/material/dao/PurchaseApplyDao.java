package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.material.bean.PurchaseApply;

public class PurchaseApplyDao {
    public int add(PurchaseApply p){
        try(Connection c=DBUtil.getConn()){
            String sql="insert into purchase_apply(purchase_no,dept,item,spec,num,usage_desc,file_path,apply_user) values(?,?,?,?,?,?,?,?)";
            PreparedStatement ps=c.prepareStatement(sql);
            ps.setString(1,p.getPurchaseNo()); ps.setString(2,p.getDept());
            ps.setString(3,p.getItem()); ps.setString(4,p.getSpec());
            ps.setInt(5,p.getNum()); ps.setString(6,p.getUsageDesc());
            ps.setString(7,p.getFilePath()); ps.setString(8,p.getApplyUser());
            return ps.executeUpdate();
        }catch(Exception e){e.printStackTrace();return 0;}
    }
    public List<PurchaseApply> listByUser(String user){
        List<PurchaseApply> list=new ArrayList<>();
        try(Connection c=DBUtil.getConn()){
            String sql="select * from purchase_apply where apply_user=? order by create_time desc";
            PreparedStatement ps=c.prepareStatement(sql); ps.setString(1,user);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                PurchaseApply p=new PurchaseApply();
                p.setId(rs.getInt("id")); p.setPurchaseNo(rs.getString("purchase_no"));
                p.setDept(rs.getString("dept")); p.setItem(rs.getString("item"));
                p.setSpec(rs.getString("spec")); p.setNum(rs.getInt("num"));
                p.setStatus(rs.getString("status")); list.add(p);
            }
        }catch(Exception e){e.printStackTrace();}
        return list;
    }
    public List<PurchaseApply> listWait(){
        List<PurchaseApply> list=new ArrayList<>();
        try(Connection c=DBUtil.getConn()){
            String sql="select * from purchase_apply where status='待审核' order by create_time desc";
            ResultSet rs=c.createStatement().executeQuery(sql);
            while(rs.next()){
                PurchaseApply p=new PurchaseApply();
                p.setId(rs.getInt("id")); p.setPurchaseNo(rs.getString("purchase_no"));
                p.setDept(rs.getString("dept")); p.setItem(rs.getString("item"));
                p.setStatus(rs.getString("status")); list.add(p);
            }
        }catch(Exception e){e.printStackTrace();}
        return list;
    }
    public void updateStatus(int id,String status){
        try(Connection c=DBUtil.getConn()){
            String sql="update purchase_apply set status=? where id=?";
            PreparedStatement ps=c.prepareStatement(sql);
            ps.setString(1,status); ps.setInt(2,id); ps.executeUpdate();
        }catch(Exception e){e.printStackTrace();}
    }
    // 全部采购单统计
    public int countAllApply(){
        Connection conn = DBUtil.getConn();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            String sql = "select count(id) from purchase_apply";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return count;
    }

 // 已审批采购单统计
    public int countFinishApply(){
        Connection conn = DBUtil.getConn();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            // 把 audit_status 改为 status
            String sql = "select count(id) from purchase_apply where status='已审批'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
        return count;
    }// ✅ 新增：查询全部采购记录（给采购记录页面用）
    public List<PurchaseApply> listAll() {
        List<PurchaseApply> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
            // 查询所有字段，按申请时间倒序
            String sql = "select * from purchase_apply order by create_time desc";
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                PurchaseApply p = new PurchaseApply();
                p.setId(rs.getInt("id"));
                p.setPurchaseNo(rs.getString("purchase_no"));
                p.setDept(rs.getString("dept"));
                p.setItem(rs.getString("item"));
                p.setSpec(rs.getString("spec"));
                p.setNum(rs.getInt("num"));
                p.setUsageDesc(rs.getString("usage_desc"));
                p.setFilePath(rs.getString("file_path"));
                p.setApplyUser(rs.getString("apply_user"));
                p.setStatus(rs.getString("status"));
                p.setCreateTime(rs.getTimestamp("create_time")); // 必须有，否则时间不显示
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}