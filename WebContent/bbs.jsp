<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>jsp 게시판 웹사이트</title>
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}

 </style>
</head>
<body>
 	<%
 		String userID = null;
 		if(session.getAttribute("userID") !=null)	{
 			userID =(String) session.getAttribute("userID");
 			
 		}
 		int pageNumber = 1;
 		if(request.getParameter("pageNumber") != null)
 		{
 			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
 		}
 	%>
 <!-- 네비게이션  -->
 <nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed" 
    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
    aria-expaned="false">
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="main.jsp">JSP 게시판</a>
  </div> 
  
  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
   <ul class="nav navbar-nav">
    <li><a href="main.jsp">메인</a></li>
    <li class="active"><a href="bbs.jsp">게시판</a></li>
   </ul>
	<% if(userID == null) {%>
    <ul class="nav navbar-nav navbar-right">
    	 <li class="dropdown">
    		 <a href="#" class="dropdown-toggle"
     		 data-toggle="dropdown" role="button" aria-haspopup="true"
     		 aria-expanded="false">접속하기<span class="caret"></span></a>
	     	<ul class="dropdown-menu">
	   			 <li><a href="Login.jsp">로그인</a></li>
	     		 <li><a href="join.jsp">회원가입</a></li>
	     	</ul>
    	</li>
   </ul>
   
   <%} else {%>
    <ul class="nav navbar-nav navbar-right">
     	<li class="dropdown">
    		 <a href="#" class="dropdown-toggle"
     			data-toggle="dropdown" role="button" aria-haspopup="true"
     		 	aria-expanded="false">회원관리<span class="caret"></span></a>
	     	<ul class="dropdown-menu">
		   	 	<li><a href="logoutAction.jsp">로그아웃</a></li>
	     	</ul>
    	</li>
   </ul>
   <%
   	} 
   %>

  </div> 
 </nav>
 	<% if(userID != null) {%>
 <div class = "container">
 	<div class ="row">
 		<table class= "table table-striped" style = "text-align: center; border: 1px solid #ddddd">
 			<thead>
 				<tr>
 					<th style = "background-color: #eeeeee; text-align: center;">번호</th>
 					<th style = "background-color: #eeeeee; text-align: center;">제목</th>
 					<th style = "background-color: #eeeeee; text-align: center;">작성자</th>
 					<th style = "background-color: #eeeeee; text-align: center;">작성일</th>
 				</tr>
 			</thead>
 			<tbody>
 				<% 
 					BbsDAO bbsDAO = new BbsDAO();
 					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
 					for( int i =0; i <list.size(); i++)
 					{
 					
 				%>
 				<tr>
 					<td><%= list.get(i).getBbsID() %></td>
 					<td><a href = "view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n","<br>")  %></a></td>
 					<td><%= list.get(i).getUserID() %></td>
 					<td><%= list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
				
 				</tr>
 				<%} %>
 			</tbody>
 		</table>
 		
 		<%	if (pageNumber != 1){
 		%>
 			<a href = "bbs.jsp?pageNumber=<%= pageNumber -1 %>" class = "btn btn-success btn-arraw-left">이전</a>	
	
 		<%	} if(bbsDAO.nextPage(pageNumber +1 )){
 		%>
 			<a href = "bbs.jsp?pageNumber=<%= pageNumber +1 %>" class = "btn btn-success btn-arraw-left">다음</a>	
 		<%
 			}
 		%>
 		
 			<a href="write.jsp"  class ="btn btn-primary pull-right">글쓰기</a>
 	</div>
 </div>
 
 	<%}%>
	<% if(userID == null) {%>
 <!-- 로긴폼 -->

 <div class="container">
  <div class="col-lg-4"></div>
  <div class="col-lg-4">

  <!-- 점보트론 -->

   <div class="jumbotron" style="padding-top: 20px;">

   <!-- 로그인 정보를 숨기면서 전송post -->

   <form method="post" action="loginAction.jsp">
    <h3 style="text-align: center;"> 로그인화면 </h3>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
    </div>
    
    <div class="form-group">
     <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
    </div>
    <input type="submit" class="btn btn-primary form-control" value="로그인">
   </form>
  </div>
 </div>
</div>
	<%}%>
 <!-- 애니매이션 담당 JQUERY -->

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

 <!-- 부트스트랩 JS  -->

 <script src="js/bootstrap.js"></script>

</body>

</html>


