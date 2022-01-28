package user;

public class UserDTO {
	
	private String userName;
	private String userID;
	private String userPassword;
	private String userEmail;
	private String userEmailHash;
	private boolean userEmailChecked;
	private String userKakaoID;
	private String userRideLocation;
	private String userPhoneNumber;
	private boolean userRideStatus;
	private boolean userCheckRider;
	private int userRiderQueueNum;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserEmailHash() {
		return userEmailHash;
	}
	public void setUserEmailHash(String userEmailHash) {
		this.userEmailHash = userEmailHash;
	}
	public boolean isUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(boolean userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	public String getUserKakaoID() {
		return userKakaoID;
	}
	public void setUserKakaoID(String userKakaoID) {
		this.userKakaoID = userKakaoID;
	}
	public String getUserRideLocation() {
		return userRideLocation;
	}
	public void setUserRideLocation(String userRideLocation) {
		this.userRideLocation = userRideLocation;
	}
	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}
	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}
	public void setUserRideStatus(boolean userRideStatus) {
		this.userRideStatus = userRideStatus;
	}
	public boolean getUserRideStatus() {
		return userRideStatus;
	}
	public void setUserCheckRider(boolean userCheckRider) {
		this.userCheckRider = userCheckRider;
	}
	public boolean getUserCheckRider() {
		return userCheckRider;
	}
	public void setUserRiderQueueNum(int userRiderQueueNum) {
		this.userRiderQueueNum = userRiderQueueNum;
	}
	public int getUserRiderQueueNum() {
		return userRiderQueueNum;
	}
	
	public UserDTO() {
		
	}
	
	public UserDTO(String userName, String userID, String userPassword, String userEmail, String userEmailHash,
			boolean userEmailChecked, String userKakaoID, String userRideLocation, String userPhoneNumber) {
		super();
		this.userName = userName;
		this.userID = userID;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userEmailHash = userEmailHash;
		this.userEmailChecked = userEmailChecked;
		this.userKakaoID = userKakaoID;
		this.userRideLocation = userRideLocation;
		this.userPhoneNumber = userPhoneNumber;
		//this.userRideStatus = userRideStatus;
	}
	
}
