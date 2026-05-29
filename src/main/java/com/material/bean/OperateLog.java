
package com.material.bean;
import java.util.Date;
public class OperateLog {
    private Integer id;
    private String username;
    private String operate;
    private Date createTime;
    public OperateLog(String username2, String string) {
		// TODO Auto-generated constructor stub
	}
	public OperateLog() {
		// TODO Auto-generated constructor stub
	}
	// getter/setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getOperate() { return operate; }
    public void setOperate(String operate) { this.operate = operate; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
