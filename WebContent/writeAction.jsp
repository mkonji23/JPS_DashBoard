
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
			String directory ="C:/JSP/upload/"; 
			int maxSize = 1024* 1024 * 100;
			String encoding = "UTF-8";
			
			//파일 디렉토리가 없을시에 파일 디렉토리 생성
			File Folder = new File(directory);
			if (!Folder.exists()) {
				try{
				    Folder.mkdir(); //폴더 생성합니다.
			        } 
			        catch(Exception e){
				    e.getStackTrace();
				}        
	         }
			
			MultipartRequest multipartRequest 
			= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
			
			String bbsTitle = multipartRequest.getParameter("bbsTitle");
			String bbsContent = multipartRequest.getParameter("bbsContent");
			
				if (bbsTitle == null || bbsContent == null ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
	
				} else{
					
					BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
					//글쓰기 성공
					
					int result = bbsDAO.write(multipartRequest.getParameter("bbsTitle"), userID, multipartRequest.getParameter("bbsContent"));		
					
					Enumeration fileNames = multipartRequest.getFileNames();
					
					while(fileNames.hasMoreElements()){
						String parameter = (String)fileNames.nextElement();
						String fileName = multipartRequest.getOriginalFileName(parameter);
						String fileRealName = multipartRequest.getFilesystemName(parameter);
						
						if(fileName ==null)continue;
						if(!fileName.endsWith(".doc") && !fileName.endsWith(".hwp")&& !fileName.endsWith(".zip")&& !fileName.endsWith(".docx")
								&& !fileName.endsWith(".pdf") && !fileName.endsWith(".xls")){
							File file  = new File(directory + fileRealName);
							file.delete();
							out.write("업로드 할 수 없는 확장자입니다.<br>");
						} else{		
							new FileDAO().upload(fileName, fileRealName);
					
						}
					}
				
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



