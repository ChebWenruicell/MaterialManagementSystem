
package com.material.servlet;
import java.io.IOException;
import java.util.List;
import com.material.bean.Material;
import com.material.bean.OperateLog;
import com.material.bean.SysUser;
import com.material.dao.MaterialDao;
import com.material.dao.OperateLogDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/material/*")
public class MaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MaterialDao materialDao = new MaterialDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        SysUser loginUser = (SysUser) session.getAttribute("user");
        if ("/list".equals(path)) {
            List<Material> list = materialDao.list();
            request.setAttribute("list", list);
            request.getRequestDispatcher("/admin/materialList.jsp").forward(request, response);
        } else if ("/add".equals(path)) {
            String name = request.getParameter("materialName");
            String spec = request.getParameter("spec");
            Double price = Double.parseDouble(request.getParameter("price"));
            String unit = request.getParameter("unit");
            Material m = new Material();
            m.setMaterialName(name);
            m.setSpec(spec);
            m.setPrice(price);
            m.setUnit(unit);
            materialDao.add(m);
            new OperateLogDao().add(new OperateLog(loginUser.getUsername(), "新增物资：" + name));
            response.sendRedirect("list");
        }
    }
}