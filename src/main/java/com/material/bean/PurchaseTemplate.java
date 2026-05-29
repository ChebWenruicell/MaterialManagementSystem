
package com.material.bean;
import java.util.Date;
public class PurchaseTemplate {
    private Integer id;
    private String templateName;
    private String fieldList;
    private String requiredList;
    private Integer status;
    private Date createTime;
    // getter/setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getTemplateName() { return templateName; }
    public void setTemplateName(String templateName) { this.templateName = templateName; }
    public String getFieldList() { return fieldList; }
    public void setFieldList(String fieldList) { this.fieldList = fieldList; }
    public String getRequiredList() { return requiredList; }
    public void setRequiredList(String requiredList) { this.requiredList = requiredList; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
