package writing;

public class WritingDTO {
	
	private int writeID;
	private String userID;
	private String userName;
	private String writeTitle;
	private String writeType;
	private String writeContent;
	private int likeCount;
	
	public int getWriteID() {
		return writeID;
	}
	public void setWriteID(int writeID) {
		this.writeID = writeID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getWriteTitle() {
		return writeTitle;
	}
	public void setWriteTitle(String writeTitle) {
		this.writeTitle = writeTitle;
	}
	public String getWriteType() {
		return writeType;
	}
	public void setWriteType(String writeType) {
		this.writeType = writeType;
	}
	public String getWriteContent() {
		return writeContent;
	}
	public void setWriteContent(String writeContent) {
		this.writeContent = writeContent;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public WritingDTO() {
		
	}
	public WritingDTO(int writeID, String userID, String userName, String writeTitle, String writeType,
			String writeContent, int likeCount) {
		super();
		this.writeID = writeID;
		this.userID = userID;
		this.userName = userName;
		this.writeTitle = writeTitle;
		this.writeType = writeType;
		this.writeContent = writeContent;
		this.likeCount = likeCount;
	}
}
