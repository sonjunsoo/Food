<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//세션 체크
	String email = (String)session.getAttribute("email");
	System.out.println(email);
	if(email != null){
	//email 값 있으면
	System.out.println(email);
	} else{
	//email 값 없으면
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand/logo -->
  <a class="navbar-brand" href="index.jsp">4학4</a>
  <!-- Links -->
  <ul class="navbar-nav">
    <li class="nav-item">
    <% if(email != null) {%>
      <a class="nav-link" href="store.jsp">맛집 추가</a>
      <% } %>
    </li>
    
    <li class="nav-item">
      <a class="nav-link" href="f_print.jsp">맛집 목록</a>
    </li>

    <li class="nav-item">
    <% if(email == null) {%> 
  		<a class="nav-link" onclick="alert('로그인이 필요한 서비스입니다.')" href="Ryan_login.jsp">맛집 추천</a>
      <%} else {%>
      <a class="nav-link" href="random.jsp">맛집 추천</a>
      <% } %>
    </li>
    
<li class="nav-item">
<% if(email == null) {%>
      <a class="nav-link" href="Ryan_login.jsp">로그인</a>
      <%} else {%>
      <a class="nav-link" href="logout.jsp">로그아웃</a>
      <% } %>
    </li>
  </ul>
  
  <form class="form-inline ml-auto" action="search.jsp">
    <input class="form-control mr-sm-2" type="text" name="search" placeholder="맛집 검색">
    <button class="btn btn-success" class="form-control mr-sm-2" type="submit">검색</button>
  </form>
</nav>
</body>
</html>