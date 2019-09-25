<%@page import="food.UserVO"%>
<%@page import="java.sql.ResultSet"%>
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
	

// 점수 DB 저장
	Connection conn = null;			
	Boolean connect = false;
		
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "SELECT * FROM users WHERE email = ? AND pw = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, pw);
		
		ResultSet rs = pstmt.executeQuery();

		out.println("<script>");
		if(rs.next()){
			//로그인 성공  // uservo 통째로 담기
			UserVO u_vo = new UserVO();
			u_vo.setEmail(rs.getString("email"));
			u_vo.setPw(rs.getString("pw"));
			u_vo.setName(rs.getString("name"));
			u_vo.setPhone(rs.getString("phone"));
			u_vo.setGrade(rs.getString("grade"));
			
			session.setAttribute("login", u_vo); 
			
			String u_name = u_vo.getName();
			out.println("alert('"+ u_name +"님 4학4 방문을 환영합니다~');");
			out.println("location.href='index.jsp'");
			
		}else{
			//로그인 실패
			out.println("alert('아이디 또는 비밀번호 재확인');");
			out.println("location.href='Ryan_login.jsp'");

	}	
		out.println("</script>");
		
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
		
	if (connect == true) {			
		System.out.println("연결");
		
	} else {	
		System.out.println("연결실패");
	}	
%> 