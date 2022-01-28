package likey;

public class LikeyDTO {
	String userID;
	int writeID;
	String userIP;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getWriteID() {
		return writeID;
	}
	public void setWriteID(int writeID) {
		this.writeID = writeID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	public LikeyDTO() {
		
	}
	public LikeyDTO(String userID, int writeID, String userIP) {
		super();
		this.userID = userID;
		this.writeID = writeID;
		this.userIP = userIP;
	}
}
