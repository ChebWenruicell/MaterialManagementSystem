package com.material.bean;

public class Todo {
    private int id;
    private String content;
    private String role;
    private String status;

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
}