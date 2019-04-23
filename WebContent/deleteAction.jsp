<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO" %> <!-- bbs의 클래스 가져옴 -->
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<%@ page import = "file.FileDTO" %>
<%@ page import = "file.FileDAO" %>
<%@ page import = "java.io.File" %>


<% request.setCharacterEncoding("UTF-8"); %>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->



<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>

	<%
			//라긴된 회원들은 페이지에 접속 할 수 없도록
		String userID = null;
		if(session.getAttribute("userID") != null ){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'Login.jsp'");
			script.println("</script>");	
		}
						
		int bbsID = 0;
 		if(request.getParameter("bbsID") != null){
 			bbsID = Integer.parseInt(request.getParameter("bbsID"));
  		}
 		
 		if(bbsID==0){
 			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href= 'bbs.jsp'");
			script.println("</script>");
 		}
 		Bbs bbs = new BbsDAO().getBbs(bbsID);
 		if( !userID.equals(bbs.getUserID())){
 			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href= 'bbs.jsp'");
			script.println("</script>");
 		}
 		
		else{
				BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
				int result = bbsDAO.delete(bbsID);		 
				new FileDAO().deleteFile(bbsID);
				if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
					}

				else {
					ArrayList<FileDTO> fileList = new FileDAO().getList(bbsID);
					for(FileDTO file : fileList)
						{
							File file1  = new File("C:/JSP/upload/"+ file.getFileRealName());
							file1.delete();
						}
				
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");

					}

			}
		

			%>

</body>



</html>



