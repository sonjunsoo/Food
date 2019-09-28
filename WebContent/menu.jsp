<%@page import="food.UserVO"%>
<%@page import="food.MenuVO"%>
<%@page import="food.StoreVO"%>
<%@page import="java.util.ArrayList"%>										
<%@page import="food.FoodVO"%>										
<%@page import="java.sql.ResultSet"%>										
<%@page import="java.sql.PreparedStatement"%>										
<%@page import="javax.sql.DataSource"%>										
<%@page import="javax.naming.InitialContext"%>										
<%@page import="javax.naming.Context"%>										
<%@page import="java.sql.Connection"%>										
<%@ page language="java" contentType="text/html; charset=UTF-8"										
	pageEncoding="UTF-8"%>									
										
<%					
	UserVO uvo = (UserVO)session.getAttribute("login");

	request.setCharacterEncoding("utf-8"); // 한글
	String s_name = request.getParameter("s_name"); // 가게이름
	String s_id = request.getParameter("s_id");	// DB에서 메뉴 불러 오기 위한 가게 ID	

//	String ob = request.getParameter("orderby"); // 오름차순
	//System.out.println(ob);									
										
	//위 데이터를 데이터 베이스에 넣기									
	Connection conn = null;									
	Boolean connect = false;									
										
	ArrayList<MenuVO> list = new ArrayList<>();									
										
	try {									
		Context init = new InitialContext();								
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kndb");								
		conn = ds.getConnection();								
		String sql = null;								
		boolean isDesc = false;								
										
// 		if (ob == null) {								
// 			//내림차순							
										
 			sql = "SELECT * FROM menu where s_id= ?";							
										
// 		} else {								
// 			//오름차순							
// 			sql = "SELECT * FROM menu where s_id= ? ORDER BY price asc";							
// 		}								
		PreparedStatement pstmt = conn.prepareStatement(sql);			
		pstmt.setString(1, s_id);
		ResultSet rs = pstmt.executeQuery();					
										
		while (rs.next()) {								
			MenuVO vo = new MenuVO();							
			vo.setId(rs.getInt("id"));												
			vo.setName(rs.getString("name"));							
			vo.setPrice(rs.getString("price"));	
			vo.setStar_avg(rs.getString("star_avg"));
			list.add(vo);							
		}		
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
<!DOCTYPE html>										
<html>										
<head>										
<title>전체 맛집</title>										
<meta charset="utf-8">										
<meta name="viewport" content="width=device-width, initial-scale=1">										
<link rel="stylesheet"										
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">									
<script										
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>									
<script										
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>									
<script										
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>									
										
										
<style>										
	.starR {									
	background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;									
	background-size: auto 100%;									
	width: 30px;									
	height: 30px;									
	display: inline-block;									
	text-indent: -9999px;									
	cursor: pointer;									
	}									
	.starR.on{background-position:0 0;}									
</style>										
<script>			
$(document).ready(function(){
	var score = 5;	// 별점 초기값
	// 클릭마다 바뀜
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  
		  console.log($(this).addClass('on').text());
		  score = $(this).addClass('on').text();
		  
		  return false;
		});
	$("#star").click(function(){								
		$.post("star_proc.jsp",								
				{								
				menu: $('#m_menuname').text(),								
				star: score								
				},								
				function(data,status){								
				alert("Data: " + data + "\nStatus: " + status);								
				});								
				});							
																				
		
	//ajax 사용													
		$("#addmenu").click(function(){								
		$.post("m_data.jsp",								
		{	
		name: $('#menu').val(),								
		price: $('#price').val(),
		img: $('#img').val(),								
		s_id : $('#s_id').val()
		},								
		function(data,status){								
			// alert("Data: " + data + "\nStatus: " + status);								
			if(data==1){
				alert("메뉴 추가 성공!");
			}else{
				alert("오류, 관리자 문의");
			}
		modalClose();
		});								
	});				
});												
										
function getMenuName(name) {									
	// alert(name);		
	$('#m_menuname').text(name);
	$('#myModal').show();
}									
function modalClose(){
	location.reload();
//	$('#myModal').hide();								
}		
														
function Close() {
	history.back();
}

</script>										
</head>										
<body>										
	<jsp:include page="top.jsp" flush="false" />									
										
	<div class="container">	
						
		<h2><%=s_name %></h2>							
 	
		<table class="table">								
			<thead>							
				<tr>														
<%-- 					<%					 --%>
<!--  						if (ob == null) {				 -->
<%-- 					%>					 --%>
<%-- 					<th>메뉴이름<a href="menu.jsp?s_id=<%=s_id %>&orderby=1">↓</a></th>					 --%>
<%-- 					<%					 --%>
<!--  						} else {				 -->
<%-- 					%>					 --%>
<%-- 					<th>메뉴이름<a href="menu.jsp?s_id<%=s_id%>">↑</a></th>					 --%>
<%-- 					<%					 --%>
<!--  						}				 -->
<%-- 					%>					 --%>
					<th>메뉴이름</th>							
					<th>가격</th>	
					<th>평점</th>							
										
				</tr>						
			</thead>							
			<tbody>							
				<%						
					for (MenuVO vo : list) {					
				%>						
				<tr class="table-dark text-dark">
				<td id="m_menuname"><a href="review.jsp?m_id=<%=vo.getId()%>&m_name=<%=vo.getName()%>"><%=vo.getName()%></a></td>	
				<td><%=vo.getPrice()%></td>			
				<td><%=vo.getStar_avg() %></td>				
				</tr>						
				<%						
					}					
				%>						
			</tbody>							
		</table>
		<%if(uvo != null && uvo.getGrade()>9) {%>		
		<button type="button" class="btn btn-primary" style="float: right" data-toggle="modal" data-target="#myModal">메뉴 추가하기</button>							
	      <% } %>
	</div>									
										
	<!-- 모달 시작 -->									
	<!-- The Modal -->
<!--  <form action="m_data.jsp">									 -->
	<div class="modal" id="myModal">									
		<div class="modal-dialog">								
			<div class="modal-content">							
										
				<!-- Modal Header -->						
				<div class="modal-header">						
					<h4 class="modal-title"><%=s_name %> 메뉴 추가</h4>					
				</div>						
										
				<!-- Modal body -->						
				<div class="modal-body">	
			<label for="menu">메뉴:</label>
      		<input type="text" class="form-control" id="menu" placeholder="메뉴 이름 입력" name="menu">
      		
			<label for="price">가격:</label>
     		<input type="number" class="form-control" id="price" placeholder="가격 입력" name="price">
     		
     		<label for="img">이미지 주소:</label>
      		<input type="text" class="form-control" id="img" placeholder="이미지 주소" name="img">
      		
     		<input type="hidden"id = "s_id" name ="s_id" value = "<%=s_id%>">													
				</div>						
				<!-- Modal footer -->						
				<div class="modal-footer">						
					<button type="submit" class="btn btn-primary" id="addmenu">메뉴 추가</button>					
					<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="modalClose()">취소</button>					
				</div>													
			</div>							
		</div>								
	</div>	
<!-- 	</form>								 -->
<!-- 모달 끝-->										
										
</body>										
</html>										