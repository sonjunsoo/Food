<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8"); //한글
	String menu = request.getParameter("menu");
	String star = request.getParameter("star");
	
	out.println(menu+"에 "+"별점 "+star+"점!");
%> 