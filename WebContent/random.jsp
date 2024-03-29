<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="food.FoodVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
 String name = request.getParameter("name");
 String menu = request.getParameter("menu");
 String home = request.getParameter("home");
 String price = request.getParameter("price");
 String loc = request.getParameter("loc");
 String star = request.getParameter("star");
 String tel = request.getParameter("tel");
 String time = request.getParameter("time");

 	Connection conn = null;			
	Boolean connect = false;
		
	ArrayList<FoodVO> list = new ArrayList<>();
	
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "select * from food";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()){
			FoodVO vo = new FoodVO();
			vo.setName(rs.getString("name"));
			vo.setMenu(rs.getString("menu"));
			vo.setHome(rs.getString("home"));
			vo.setPrice(rs.getString("price"));
			vo.setLoc(rs.getString("loc"));
			vo.setStar(rs.getString("star"));
			vo.setTel(rs.getString("tel"));
			vo.setTime(rs.getString("time"));
			
			list.add(vo);
		}
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
		
	if (connect == true) {	
		System.out.println("연결되었습니다.");
	} else {	
		System.out.println("연결실패.");
	}	
	
	int random = (int) (Math.random()*list.size());
	
//	Random rnd = new Random();
//int rNum = rnd.nextInt(list.size());
	
	FoodVO fvo = list.get(random);
	System.out.println(fvo.getMenu());
%>
<!DOCTYPE html>
<html>
<head>
  <title>댓거리 맛집 추천!</title> 
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/>

<div class="container">
<h1>맛집 추천!</h1>
  <table class="table">
    <thead>
      <tr>
        <th>가게이름</th>
        <th>메뉴</th>
        <th>원산지</th>
        <th>가격</th>
        <th>위치</th>
        <th>별점</th>
        <th>전화번호</th>
        <th>영업시간</th>
      </tr>
    </thead>
    <tbody>
      <tr class="table-dark text-dark">
        <td><%=fvo.getName() %></td>
        <td><%=fvo.getMenu() %></td>
        <td><%=fvo.getHome() %></td>
        <td><%=fvo.getPrice() %></td>
        <td><%=fvo.getLoc() %></td>
        <td><%=fvo.getStar() %></td>
        <td><%=fvo.getTel() %></td>
        <td><%=fvo.getTime() %></td>
      </tr>
      
    </tbody>
  </table>
</div>

</body>
</html>

