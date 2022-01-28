package writing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class WritingDAO {
	
	public int write(WritingDTO writingDTO) {
		String SQL = "INSERT INTO WRITING VALUES (NULL, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, writingDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, writingDTO.getUserName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, writingDTO.getWriteTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4, writingDTO.getWriteType().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(5, writingDTO.getWriteContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return -1; // 데이터 베이스 오류
	}
	
	public ArrayList<WritingDTO> getList(String writeType, String searchType, String search, int pageNumber) {
		if(writeType.contentEquals("전체")) {
			writeType = "";
		}
		ArrayList<WritingDTO> writeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "";
		try {
			if(searchType.contentEquals("최신순")) {
				SQL = "SELECT * FROM WRITING WHERE writeType LIKE ? AND CONCAT(userName, writeTitle, writeContent) LIKE ? ORDER BY writeID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("공감순")) {
				SQL = "SELECT * FROM WRITING WHERE writeType LIKE ? AND CONCAT(userName, writeTitle, writeContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
		conn = DatabaseUtil.getConnection();
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, "%" + writeType + "%");
		pstmt.setString(2, "%" + search + "%");
		rs = pstmt.executeQuery();
		writeList = new ArrayList<WritingDTO>();
		while(rs.next()) {
			WritingDTO writing = new WritingDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getInt(7)
					);
			writeList.add(writing);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
		try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
		try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
	}
	return writeList;
	}
	
	public int like(String writeID) {
		String SQL = "UPDATE WRITING SET likeCount = likeCount + 1 WHERE writeID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(writeID));
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return -1; // 데이터 베이스 오류
	}
	
	public int delete(String writeID) {
		String SQL = "DELETE FROM WRITING WHERE writeID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(writeID));
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return -1; // 데이터 베이스 오류
	}
	
	public String getUserID(String writeID) {
		String SQL = "SELECT userID FROM WRITING WHERE writeID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(writeID));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (pstmt != null) pstmt.close(); } catch (Exception e ) { e.printStackTrace(); }
			try { if (rs != null) rs.close(); } catch (Exception e ) { e.printStackTrace(); }
		}
		return null; // 데이터 베이스 오류
	}
}
