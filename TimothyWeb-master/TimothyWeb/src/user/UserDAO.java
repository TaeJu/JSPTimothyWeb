package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DatabaseUtil;

public class UserDAO {
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 틀림
				}
			}
			return -1; // 아이디 존재 하지않음
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return -2; // 데이터 베이스 오류
	}
	
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, false, ?, ?, ?, false, false, -1)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserEmailHash());
			pstmt.setString(6, user.getUserKakaoID());
			pstmt.setString(7, user.getUserRideLocation());
			pstmt.setString(8, user.getUserPhoneNumber());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return -1; // 회원가입 실패
	}
	
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);
			} // 이메일 주소 반환
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return null;
	}
	
	public String getUserName(String userID) {
		String SQL = "SELECT userName FROM USER WHERE userID =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);
			} // 이름 반환
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return null;
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1); // 이메일 등록 여부 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 데이트베이스 오류
	}
	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 이메일 등록 설정 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 이메일 등록 설정 실패
	}
	
	public boolean getCurrentUserRideStatus(String userID) {
		String SQL = "SELECT userRideStatus FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1); // 라이드 상태 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 데이트베이스 오류
	}
	
	public boolean setUserRideStatusRegister(String userID) {
		String SQL = "UPDATE USER SET userRideStatus = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 라이드 상태 변경 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 라이드 상태 변경 실패
	}
	
	public boolean setUserRideStatusCancel(String userID) {
		String SQL = "UPDATE USER SET userRideStatus = false WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 라이드 상태 변경 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 라이드 상태 변경 실패
	}
	
	public boolean setUserRideStatusManagerReset() {
		String SQL = "UPDATE USER SET userRideStatus = false WHERE userRideStatus = true";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			return true; // 라이드 상태 변경 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 라이드 상태 변경 실패
	}
	
	public boolean setUserRiderQueueNumManagerReset() {
		String SQL = "UPDATE USER SET userRiderQueueNum = -1";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			return true; // 라이더 큐 넘버 상태 변경 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 라이드 큐 넘버 상태 변경 실패
	}
	
	public boolean getUserCheckRider(String userID) {
		String SQL = "SELECT userCheckRider FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1); // 라이더 인지 상태 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 데이트베이스 오류
	}
	
	public boolean setUserCheckRider(String userID) {
		String SQL = "UPDATE USER SET userCheckRider = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 라이더 상태 변경 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 라이드 상태 변경 실패
	}
	
	public int getUserRiderQueueNum(String userID) {
		String SQL = "SELECT userRiderQueueNum FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getInt(1); // 큐넘버 변환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return -1; // 데이트베이스 오류
	}
	
	public boolean setUserRiderQueueNum(String userID, int queueNum) {
		String SQL = "UPDATE USER SET userRiderQueueNum = " + queueNum + " WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 라이더 큐 넘버 변환 성공
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return false; // 라이드 큐 넘버 상태 변경 실패
	}
}
