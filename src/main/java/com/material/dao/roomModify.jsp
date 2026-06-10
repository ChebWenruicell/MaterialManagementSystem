<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>room modify</title>
</head>
<body>
<%!
int id;
	String strName;
	int status;
%>
<%
Object ssName = session.getAttribute("username");
if (ssName == null){	  
    out.print("<script>");
    out.print("alert('please login!');");
    out.print("location.href='roomLogin.jsp');");
    out.print("</script>");	
	//response.sendRedirect("roomLogin.jsp");
return;
}

	id = Integer.parseInt(request.getParameter("id"));
    strName = request.getParameter("name");
    String strStatus = request.getParameter("status");

final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
final String DB_URL = "jdbc:mysql://localhost:3307/studentmanage";
final String USER = "root";
final String PASS = ""; 

Connection conn = null;
Statement stmt = null;

if (strName != null) {
    try{
	    // 注册 JDBC 驱动器
	    Class.forName("com.mysql.jdbc.Driver");    
	    // 打开一个连接
	    conn = DriverManager.getConnection(DB_URL,USER,PASS);	    
	    String sql;
	    
	    sql = "update rooms set roomName=?, roomStatus=?"
	    		+ " where roomId=?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, strName);
	    pstmt.setInt(2, Integer.parseInt(strStatus));
	    pstmt.setInt(3, id);
	    pstmt.execute();	    

		pstmt.close();
	    conn.close();
	    out.println("modify data success!");
	    
	    out.print("<script>");
	    out.print("alert('modify success！');");
	    out.print("location.href='roomShow.jsp');");
	    out.print("</script>");
	    
	    //out.print("<script>alert('modify success!');</script>");
	    //response.sendRedirect("roomShow.jsp");
    }
	 catch(SQLException se) {
		 out.println(se.getMessage());
	    // 处理 JDBC 错误
	    //se.printStackTrace();
	} catch(Exception e) {
		out.println(e.getMessage());
	    // 处理 Class.forName 错误
	    //e.printStackTrace();
	}
}
else {
	try{
	    // 注册 JDBC 驱动器
	    Class.forName("com.mysql.jdbc.Driver");    
	    // 打开一个连接
	    conn = DriverManager.getConnection(DB_URL,USER,PASS);
	    
	    stmt = conn.createStatement();
	    String sql;
	    sql = "select roomName, roomStatus from rooms " +
	    		" where roomId=?";	    
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, id);   
	    ResultSet rs = pstmt.executeQuery();
	    
	    if(rs.next()){
	        // 通过字段检索
	        strName = rs.getString("roomName");
	        status = rs.getInt("roomStatus");
	    }    
	    rs.close();
	    stmt.close();
	    conn.close();
	}
	 catch(SQLException se) {
		 out.println(se.getMessage());
	    // 处理 JDBC 错误
	    //se.printStackTrace();
	} catch(Exception e) {
		out.println(e.getMessage());
	    // 处理 Class.forName 错误
	    //e.printStackTrace();
	}
}

%>

<form action="roomModify.jsp" method="post">
    id：<input type="text" name="id"
     value="<%= id %>" 
     readonly><br><br>
    name：<input type="text" name="name"
     value="<%= strName %>"><br><br>
    status：<input type="text" name="status"
     value="<%= status %>"><br><br>
    <button type="submit">modify</button>
</form>

</body>
</html>