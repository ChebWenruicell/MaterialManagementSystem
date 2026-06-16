package com.material.servlet;

import com.material.dao.MaterialDao;
import com.material.bean.Material;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/purchaser/searchMaterial")
public class SearchMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MaterialDao materialDao = new MaterialDao();

    // JSON字符串转义，防止物资名称带双引号破坏格式
    private String escapeJson(String str) {
        if(str == null) return "";
        return str.replace("\"", "\\\"");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        String keyword = request.getParameter("keyword");
        // 此处替换为你Dao里真实方法 searchByName
        List<Material> list = materialDao.searchByName(keyword);

        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for(int i = 0; i < list.size(); i++){
            Material m = list.get(i);
            sb.append("{");
            sb.append("\"materialName\":\"").append(escapeJson(m.getMaterialName())).append("\",");
            sb.append("\"spec\":\"").append(escapeJson(m.getSpec())).append("\",");
            sb.append("\"unit\":\"").append(escapeJson(m.getUnit())).append("\"");
            sb.append("}");
            if(i != list.size() - 1){
                sb.append(",");
            }
        }
        sb.append("]");
        response.getWriter().write(sb.toString());
    }
}