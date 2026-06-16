package com.material.bean;

import java.util.Date;

public class PurchaseRecord {
    private Integer id;
    private String dept;
    private String item;
    private String spec;
    private Integer num;
    private String usage;
    private Date createTime;
    private Integer status; // 0待审核 1通过 2驳回

    // getter setter
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public String getDept() {return dept;}
    public void setDept(String dept) {this.dept = dept;}
    public String getItem() {return item;}
    public void setItem(String item) {this.item = item;}
    public String getSpec() {return spec;}
    public void setSpec(String spec) {this.spec = spec;}
    public Integer getNum() {return num;}
    public void setNum(Integer num) {this.num = num;}
    public String getUsage() {return usage;}
    public void setUsage(String usage) {this.usage = usage;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
    public Integer getStatus() {return status;}
    public void setStatus(Integer status) {this.status = status;}
}