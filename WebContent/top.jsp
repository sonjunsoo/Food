<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      <a class="nav-link" href="login.html">로그인</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="insert.jsp">맛집 추가</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="print.jsp">맛집 목록</a>
    </li>
    <form class="form-inline" action="/action_page.php">
    <input class="form-control mr-sm-2" type="text" placeholder="맛집 검색">
    <button class="btn btn-success" type="submit">검색</button>
  </form>
  </ul>
</nav>
</body>
</html>