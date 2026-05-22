package com.material.bean;
import java.util.Date;
public class PurchaseApply {
    private Integer id;
    private String purchaseNo;
    private String dept;
    private String item;
    private String spec;
    private Integer num;
    private String usageDesc;
    private String filePath;
    private String applyUser;
    private String status;
    private Date createTime;
	//getter + setter
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id=id;}
    public String getPurchaseNo() {return purchaseNo;}
    public void setPurchaseNo(String purchaseNo) {this.purchaseNo=purchaseNo;}
    public String getDept() {return dept;}
    public void setDept(String dept) {this.dept=dept;}
    public String getItem() {return item;}
    public void setItem(String item) {this.item=item;}
    public String getSpec() {return spec;}
    public void setSpec(String spec) {this.spec=spec;}
    public Integer getNum() {return num;}
    public void setNum(Integer num) {this.num=num;}
    public String getUsageDesc() {return usageDesc;}
    public void setUsageDesc(String usageDesc) {this.usageDesc=usageDesc;}
    public String getFilePath() {return filePath;}
    public void setFilePath(String filePath) {this.filePath=filePath;}
    public String getApplyUser() {return applyUser;}
    public void setApplyUser(String applyUser) {this.applyUser=applyUser;}
    public String getStatus() {return status;}
    public void setStatus(String status) {this.status=status;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime=createTime;}
}