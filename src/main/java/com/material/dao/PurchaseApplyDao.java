package com.material.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
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
                p.setCreateTime(rs.getTimestamp("create_time"));
                list.add(p);
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
                p.setCreateTime(rs.getTimestamp("create_time"));
                list.add(p);
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
            // 数据库真实状态是 已通过，不是已审批
            String sql = "select count(id) from purchase_apply where status='已通过'";
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

    // 查询全部采购记录（给采购记录页面用）
    public List<PurchaseApply> listAll() {
        List<PurchaseApply> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
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
                p.setCreateTime(rs.getTimestamp("create_time"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 新增1：统计待审核采购单数量
    public int countWaitApply(){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try{
            conn = DBUtil.getConn();
            String sql = "SELECT COUNT(id) FROM purchase_apply WHERE status='待审核'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try{if(rs != null) rs.close();}catch(Exception e){}
            try{if(pstmt != null) pstmt.close();}catch(Exception e){}
            try{if(conn != null) conn.close();}catch(Exception e){}
        }
        return 0;
    }

    // 新增2：统计已驳回采购单数量
    public int countRejectApply(){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try{
            conn = DBUtil.getConn();
            String sql = "SELECT COUNT(id) FROM purchase_apply WHERE status='已驳回'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try{if(rs != null) rs.close();}catch(Exception e){}
            try{if(pstmt != null) pstmt.close();}catch(Exception e){}
            try{if(conn != null) conn.close();}catch(Exception e){}
        }
        return 0;
    }

    // 新增：根据采购单ID查询完整单据（审核详情页专用）
    public PurchaseApply getById(int id){
        PurchaseApply p = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = DBUtil.getConn();
            String sql = "select * from purchase_apply where id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if(rs.next()){
                p = new PurchaseApply();
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
                p.setCreateTime(rs.getTimestamp("create_time"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try{if(rs!=null)rs.close();}catch(Exception e){}
            try{if(ps!=null)ps.close();}catch(Exception e){}
            try{if(conn!=null)conn.close();}catch(Exception e){}
        }
        return p;
    }

    // 多条件筛选采购记录：关键词(单号/物资名称)+状态（新增筛选方法）
    public List<PurchaseApply> listByFilter(String keyword, String status) {
        List<PurchaseApply> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
            StringBuilder sql = new StringBuilder("SELECT * FROM purchase_apply WHERE 1=1 ");
            List<Object> params = new ArrayList<>();

            // 模糊匹配采购单号、物资名称
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND (purchase_no LIKE ? OR item LIKE ?) ");
                params.add("%" + keyword.trim() + "%");
                params.add("%" + keyword.trim() + "%");
            }
            // 状态精准筛选
            if (status != null && !status.trim().isEmpty()) {
                sql.append(" AND status = ? ");
                params.add(status.trim());
            }
            sql.append(" ORDER BY create_time DESC");

            PreparedStatement ps = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
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
                p.setCreateTime(rs.getTimestamp("create_time"));
                list.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 新增：待审核单据 按采购单号/物资名称模糊筛选（审批人待审核页面专用）
    public List<PurchaseApply> listWaitByKeyword(String keyword) {
        List<PurchaseApply> list = new ArrayList<>();
        try (Connection c = DBUtil.getConn()) {
            StringBuilder sql = new StringBuilder("SELECT * FROM purchase_apply WHERE status='待审核' ");
            List<Object> params = new ArrayList<>();

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND (purchase_no LIKE ? OR item LIKE ?) ");
                params.add("%" + keyword.trim() + "%");
                params.add("%" + keyword.trim() + "%");
            }
            sql.append(" ORDER BY create_time DESC");

            PreparedStatement ps = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
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
                p.setCreateTime(rs.getTimestamp("create_time"));
                list.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ========== 下面3个为采购人工作台新增统计方法 ==========
    // 统计当前采购人全部采购单
    public int countByUser(String username){
        int count = 0;
        try(Connection c=DBUtil.getConn()){
            String sql="select count(id) from purchase_apply where apply_user=?";
            PreparedStatement ps=c.prepareStatement(sql);
            ps.setString(1,username);
            ResultSet rs=ps.executeQuery();
            if(rs.next()) count=rs.getInt(1);
            rs.close();
            ps.close();
        }catch(Exception e){e.printStackTrace();}
        return count;
    }

    // 统计当前采购人 待审核 单据数量
    public int countWaitByUser(String username){
        int count = 0;
        try(Connection c=DBUtil.getConn()){
            String sql="select count(id) from purchase_apply where apply_user=? and status='待审核'";
            PreparedStatement ps=c.prepareStatement(sql);
            ps.setString(1,username);
            ResultSet rs=ps.executeQuery();
            if(rs.next()) count=rs.getInt(1);
            rs.close();
            ps.close();
        }catch(Exception e){e.printStackTrace();}
        return count;
    }

    // 统计当前采购人 已通过(已完成)单据数量
    public int countFinishByUser(String username){
        int count = 0;
        try(Connection c=DBUtil.getConn()){
            String sql="select count(id) from purchase_apply where apply_user=? and status='已通过'";
            PreparedStatement ps=c.prepareStatement(sql);
            ps.setString(1,username);
            ResultSet rs=ps.executeQuery();
            if(rs.next()) count=rs.getInt(1);
            rs.close();
            ps.close();
        }catch(Exception e){e.printStackTrace();}
        return count;
    }
}