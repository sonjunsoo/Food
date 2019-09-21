<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"										
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8"); //한글
	String email = request.getParameter("email");
	String pw = request.getParameter("password");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String radio = request.getParameter("radio");

	
// 점수 DB 저장
	Connection conn = null;			
	Boolean connect = false;
		
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "INSERT INTO users (email, pw, name, phone, grade, state) VALUES (?, ?, ?, ?, ?, ?);";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, star);
		pstmt.setString(2, menu);
		
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
	} else {	
		System.out.println("연결실패");
		out.println(0);
	}	
%> 