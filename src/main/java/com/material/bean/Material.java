
package com.material.bean;
import java.util.Date;
public class Material {
    private Integer id;
    private String materialName;
    private String spec;
    private Double price;
    private String unit;
    private Date createTime;
	//getter + setter
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id=id;}
    public String getMaterialName() {return materialName;}
    public void setMaterialName(String materialName) {this.materialName=materialName;}
    public String getSpec() {return spec;}
    public void setSpec(String spec) {this.spec=spec;}
    public Double getPrice() {return price;}
    public void setPrice(Double price) {this.price=price;}
    public String getUnit() {return unit;}
    public void setUnit(String unit) {this.unit=unit;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime=createTime;}
}