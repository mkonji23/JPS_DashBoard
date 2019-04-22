package file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class downloadAction
 */
@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String fileName = request.getParameter("file");
		
		String directory = "C:/JSP/upload";
		File file = new File(directory + "/" + fileName);
		
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream"); // 이진의 데이터를 전송할때
		}
		
		String downloadName = null;
		if(request.getHeader("user-agent").indexOf("MSID") ==-1 ) {
			downloadName = new String(fileName.getBytes("UTF-8"),"8859_1");
			
		}else {
			downloadName = new String(fileName.getBytes("EUR-KR"),"8859_1");
		}
		
		response.setHeader("Content-Disposition","attachment;fileName=\""
				+downloadName +"\";");
		
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream =response.getOutputStream();
		
		byte b[] = new byte[1024];
		int data = 0;
		
		while((data = (fileInputStream.read(b,0,b.length)))!= -1){
			servletOutputStream.write(b, 0, data);
		}
		 
		new FileDAO().hit(fileName);
		servletOutputStream.flush(); //나머지 데이터를 다 보냄
		servletOutputStream.close(); // 서블릿을 닫아줌
		fileInputStream.close(); //파일도 닫아줌
	}



}
