
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO" %> <!-- bbs의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<!-- 파일업로드 -->
<%@ page import ="file.FileDAO" %>
<%@ page import ="java.io.File" %>
<%@ page import ="java.util.Enumeration" %>

<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
 
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" /> 


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
		else{
		
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
	
				} else{
	
				BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());		
				
				
				
									
				if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					}
	
					else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
	
					}

			}
		}
			%>

</body>



</html>



