package file;

public class FileDTO {
	String fileName;
	String fileRealName;
	int downloadCount;
	int fileNum;
	
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public int getDownloadCount() {
		return downloadCount;
	}
	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}
	public FileDTO(String fileName, String fileRealName,int downloadCount, int fileNum) {
		super();
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.downloadCount =downloadCount;
		this.fileNum = fileNum;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
}
