<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% 
 // index.jsp 에서 넘어오는 데이터 처리
 
 String name = request.getParameter("name");
 String menu = request.getParameter("menu");
 String home = request.getParameter("home");
 String price = request.getParameter("price");
 String loc = request.getParameter("loc");
 String star = request.getParameter("star");
 String tel = request.getParameter("tel");
 String time = request.getParameter("time");

 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
가게이름 :  <%=name %><br>
메뉴 :  <%=menu %><br>
원산지 :  <%=home %><br>
가격 :  <%=price+'원'%><br>
위치 :  <%=loc %><br>
별점 :  <%=star+'점' %><br>
전화번호 :  <%=tel %><br>
영업시간 :  <%=time %><br>
</body>
</html>