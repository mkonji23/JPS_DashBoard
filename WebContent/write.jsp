<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
 	<%

 	String userID = null;
 		if(session.getAttribute("userID") !=null)	{
 			userID =(String) session.getAttribute("userID");
 			
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
 <div class = "container">
 	<div class ="row">
 	 	<form method = "post" action="writeAction.jsp">
	 		<table class= "table table-striped" style = "text-align: center; border: 1px solid #ddddd">
	 			<thead>
	 				<tr>
	 					<th colspan="2" style= "background-color: #eeeeee; text-align: center;">게시판 글쓰기</th>
	 				</tr>
	 			</thead>
	 			<tbody>
	 				<tr>
	 					<td><input type = "text" class="form-control" placeholder = "글 제목 " name = "bbsTitle" maxlength = "50"></td>
	 				</tr>

	 				<tr>	
	 					<td><textarea class="form-control" placeholder = "글 내용" name = "bbsContent" maxlength = "2048" style="height: 350px"></textarea></td>
	 				</tr>
	 				
				
	 			</tbody>
	 		
	 		</table>
	 			<input type = "submit" class ="btn btn-primary pull-right" value ="글쓰기">
		</form>
 	</div>
 </div>
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


