package com.material.bean;

public class Notice {
    private int id;
    private String title;
    private String content;
    private String status;

    // 无参构造
    public Notice() {}

    // getter和setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}