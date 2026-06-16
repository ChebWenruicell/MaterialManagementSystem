package com.material.bean;

public class Todo {
    private int id;
    private String content;
    private String role;
    private String status;
    // 新增：补齐数据库表对应的创建时间字段
    private String createTime;

    // 无参构造
    public Todo() {}

    // getter和setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    // 新增：补齐 createTime 对应的 get/set 方法
    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }
}