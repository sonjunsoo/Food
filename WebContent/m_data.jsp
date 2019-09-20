<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% 
 // index.jsp 에서 넘어오는 데이터 처리
 request.setCharacterEncoding("utf-8"); //한글 깨짐 방지
 
 String name = request.getParameter("name");
 String price = request.getParameter("price");
 String img = request.getParameter("img");
 String s_id = request.getParameter("s_id");

 	Connection conn = null;			
	Boolean connect = false;
		
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "INSERT INTO menu(name, price, img, s_id) VALUES (?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, price);
		pstmt.setString(3, img);
		pstmt.setString(4, s_id);
	
		pstmt.executeUpdate();
		
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
		
	if (connect == true) {	
		System.out.println("연결되었습니다.");
		out.println(1);
	} else {	
		System.out.println("연결실패.");
		out.println(0);
	}	
%>