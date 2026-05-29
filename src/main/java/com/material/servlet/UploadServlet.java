
package com.material.servlet;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import com.material.bean.SysUser;
import com.material.bean.UploadFile;
import com.material.dao.UploadFileDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UploadFileDao uploadDao = new UploadFileDao();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        SysUser user = (SysUser) session.getAttribute("user");
        Part part = request.getPart("file");
        String fileName = part.getSubmittedFileName();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String newName = UUID.randomUUID().toString() + suffix;
        String realPath = getServletContext().getRealPath("/upload");
        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        part.write(realPath + File.separator + newName);
        String filePath = "upload/" + newName;
        String fileType = fileName.endsWith(".jpg") || fileName.endsWith(".png") ? "图片" : "附件";
        UploadFile uf = new UploadFile();
        uf.setFileName(fileName);
        uf.setFilePath(filePath);
        uf.setFileType(fileType);
        uf.setUploadUser(user.getUsername());
        uploadDao.add(uf);
        response.getWriter().write(filePath);
    }
}