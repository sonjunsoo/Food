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
	request.setCharacterEncoding("utf-8"); // 한글
	String m_name = request.getParameter("m_name"); // 메뉴이름
	UserVO uvo = (UserVO)session.getAttribute("login");	// 리뷰 입력에 필요한 유저 정보

	//위 데이터를 데이터 베이스에 넣기									
	Connection conn = null;									
	Boolean connect = false;	
	
	MenuVO mvo = new MenuVO();							
		
	try {									
		Context init = new InitialContext();								
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kndb");								
		conn = ds.getConnection();								
		String sql = null;								
		boolean isDesc = false;								
										
 					
 			sql = "SELECT * FROM menu where name = ?";							
										
 			
		PreparedStatement pstmt = conn.prepareStatement(sql);			
		pstmt.setString(1, m_name);
		ResultSet rs = pstmt.executeQuery();					
										
		if (rs.next()) {								
			mvo.setId(rs.getInt("id"));												
			mvo.setName(rs.getString("name"));							
			mvo.setPrice(rs.getString("price"));	
			mvo.setImg(rs.getString("img"));
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
				//alert("Data: " + data + "\nStatus: " + status);		
				if(data == 1){
					alert("소중한 평가, 감사합니다!");
				}else{
					alert("등록 실패, 관리자에게 문의!");
				}
				modalClose();
				});								
		});
	
	$("#submit").click(function(){
	    $.post("review_proc.jsp",
	    {
	      review: $('#comment').val(), // comment 글 가져오기 
	      m_id:$('#m_id').val(), 
	      u_id:$('#u_id').val()
	    },
	    function(data,status){								
			// alert("Data: " + data + "\nStatus: " + status);								
			if(data==1){
				alert("소중한 리뷰, 감사합니다.");
			}else{
				alert("오류, 관리자 문의");
			}
		modalClose();
	  });
																										
});																
function modalClose() {
 	location.reload();
//	history.back();
// 	$('#myModal').hide();
}

$(function() {
    $('#comment').keyup(function (e){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('#counter').html(content.length + '/50');
    });
    $('#comment').keyup();
});

function send_login() {
	alert("로그인이 필요한 서비스입니다.");
 	location.href="Ryan_login.jsp";

}
</script>										
										
</head>										
<body>										
	<jsp:include page="top.jsp" flush="false" />									
										
	<div class="container">	
						
		<h2><%=m_name %></h2> 	
		<table class="table">								
			<thead>							
				<tr>														
					<th>메뉴이름</th>							
					<th>가격</th>	
					<th>평가하기</th>
					<th>리뷰쓰기</th>							
																						
				</tr>						
			</thead>							
			<tbody>													
				<tr class="table-dark text-dark">						
				<td id="m_menuname"><%=mvo.getName()%></td>					
				<td><%=mvo.getPrice()%></td>	
				<td>
					<div class="starRev">						
					<span class="starR on">1</span>						
					<span class="starR on">2</span>						
					<span class="starR on">3</span>						
					<span class="starR on">4</span>						
					<span class="starR on">5</span>	
		<button type="button" id="star" class="btn btn-danger">확인</button>							
										
				</div>
				</td>
				<td>
				<%if(uvo==null){ %>
				<button type="button" class="btn btn-primary" onclick="send_login()">리뷰 작성</button>								
				<% } else { %>
		        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
		  			리뷰 작성
				</button>
			<% } %>
				</td>		
				</tr>						
									
			</tbody>							
		</table>
		<% if(mvo.getImg() == null || mvo.getImg().equals("")) {%>
		<p class="text-left">이미지가 없습니다.</p>	
		<%}else{ %>
		<img src="<%=mvo.getImg() %>" width="320" height="240" style="float: left" class="rounded mx-auto d-block">	
		<%} %>	
		<p class="mx-auto">리뷰 리스트</p>
	</div>						
				
		<!-- 모달 시작 -->									
	<!-- The Modal -->
<!--  <form action="r_data.jsp">									 -->
	<div class="modal" id="myModal">									
		<div class="modal-dialog">								
			<div class="modal-content">							
										
				<!-- Modal Header -->						
				<div class="modal-header">						
					<h4 class="modal-title">리뷰 작성</h4>					
				</div>						
										
				<!-- Modal body -->						
				<div class="modal-body">	
					<div class="form-group">
				 	 <label for="comment"></label>
				 	 <textarea class="form-control" rows="2" maxlength="50" id="comment"></textarea>
				 	 <input type="hidden" id=m_id value="<%=mvo.getId()%>"> 
				 	 <%if(uvo!=null){ %>
				 	 <input type="hidden" id=u_id value="<%=uvo.getId()%>"> 
				 	 <%}%>
					</div>	
					<span id="counter">###</span>																	
				</div>						
				<!-- Modal footer -->						
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" id="submit">등록</button>					
					<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="modalClose()">취소</button>					
				</div>													
			</div>							
		</div>								
	</div>	
<!-- 	</form>								 -->
<!-- 모달 끝-->																	
										
</body>										
</html>										