<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"										
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8"); //한글
	String star = request.getParameter("star");
	String m_id = request.getParameter("m_id");
	String u_id = request.getParameter("u_id");
	
// 점수 DB 저장
	Connection conn = null;			
	Boolean connect = false;
		
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		// 별점 넣기
		String sql = "INSERT INTO star (score, m_id, u_id) VALUES (?, ?, ?);";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, star);
		pstmt.setString(2, m_id);
		pstmt.setString(3, u_id);				
		pstmt.executeUpdate();
		
		// 별점 평균 업뎃
		sql = "UPDATE menu SET star_avg = CAST((SELECT AVG(score) FROM star WHERE m_id = ?) AS CHAR(10)) WHERE id = ?;";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, m_id);
		pstmt.setString(2, m_id);
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