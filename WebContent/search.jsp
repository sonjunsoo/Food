<%@page import="naver.NSearch"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8"); //한글 깨짐 방지
	String search = request.getParameter("search");
	String result = NSearch.getData(search);
	out.println(result);	 
%>	
