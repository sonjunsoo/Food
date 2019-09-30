<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"										
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8"); //한글
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String u_name = request.getParameter("u_name");
	String date = request.getParameter("date");
	String u_id = request.getParameter("u_id");
	
// 점수 DB 저장
	Connection conn = null;			
	Boolean connect = false;
	

	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "INSERT INTO board (title, content, u_name, date, u_id) VALUES (?, ?, ?, ?, ?);";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, u_name);
		pstmt.setString(4, date);
		pstmt.setString(5, u_id);

		pstmt.executeUpdate();
		
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
		
	if (connect == true) {	
		System.out.println("연결");
		out.println(1);
	}  else {	
		System.out.println("연결실패");
		out.println(0);
	}

%> 