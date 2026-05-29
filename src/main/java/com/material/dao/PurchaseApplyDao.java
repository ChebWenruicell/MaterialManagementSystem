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
}