package file;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FileDAO {
	private Connection conn;
	private ResultSet rs;
	
	public FileDAO() {
		try {
			String dbURL ="jdbc:mysql://localhost:3306/test?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String dbID ="root";
			String dbPassword = "mkonji23";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
			return 1; // 첫번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db  오류
	}
	
	public int upload(String fileName, String fileRealName) {
		String SQL = "INSERT INTO FILE VALUES(?,?,0,?,1)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setInt(3,getNext());
				
			return pstmt.executeUpdate();
			
		}catch( Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public int hit(String fileRealName) {
		String SQL = "UPDATE FILE SET downloadCount = downloadCount +1"
				+ " WHERE fileRealName = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileRealName);
			return pstmt.executeUpdate();
			
		}catch( Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<FileDTO> getList(int fileNum){
		String SQL = "SELECT * FROM FILE WHERE fileNum = ?";
		ArrayList<FileDTO>  list = new ArrayList<FileDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 pstmt.setInt(1, fileNum); 
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()){
				FileDTO file = new FileDTO(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getInt(4));
				list.add(file);
			}
		}catch( Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	public int deleteFile(int fileNum) {
		String SQL = "UPDATE FILE SET fileAvailable = 0 WHERE fileNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, fileNum);
			return pstmt.executeUpdate();			
		}catch( Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}

}
