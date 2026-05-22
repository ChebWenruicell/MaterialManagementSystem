package com.material.bean;
import java.util.Date;
public class AuditRecord {
    private Integer id;
    private Integer purchaseId;
    private String purchaseNo;
    private String auditResult;
    private String auditReason;
    private String auditUser;
    private Date auditTime;
	//getter + setter
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id=id;}
    public Integer getPurchaseId() {return purchaseId;}
    public void setPurchaseId(Integer purchaseId) {this.purchaseId=purchaseId;}
    public String getPurchaseNo() {return purchaseNo;}
    public void setPurchaseNo(String purchaseNo) {this.purchaseNo=purchaseNo;}
    public String getAuditResult() {return auditResult;}
    public void setAuditResult(String auditResult) {this.auditResult=auditResult;}
    public String getAuditReason() {return auditReason;}
    public void setAuditReason(String auditReason) {this.auditReason=auditReason;}
    public String getAuditUser() {return auditUser;}
    public void setAuditUser(String auditUser) {this.auditUser=auditUser;}
    public Date getAuditTime() {return auditTime;}
    public void setAuditTime(Date auditTime) {this.auditTime=auditTime;}
}