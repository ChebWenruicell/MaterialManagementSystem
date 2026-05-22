package com.material.bean;
import java.util.Date;
public class UploadFile {
    private Integer id;
    private String fileName;
    private String filePath;
    private String fileType;
    private String uploadUser;
    private Date uploadTime;
    // getter/setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }
    public String getUploadUser() { return uploadUser; }
    public void setUploadUser(String uploadUser) { this.uploadUser = uploadUser; }
    public Date getUploadTime() { return uploadTime; }
    public void setUploadTime(Date uploadTime) { this.uploadTime = uploadTime; }
}
