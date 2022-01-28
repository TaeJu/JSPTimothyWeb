<%@ page import="user.UserDAO" %>
<%@ page import="writing.WritingDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	request.setCharacterEncoding("UTF-8");
	String writeID = null;
	if(request.getParameter("writeID") != null) {
		writeID = (String) request.getParameter("writeID");
	}
	WritingDAO writingDAO = new WritingDAO();
	if(userID.equals(writingDAO.getUserID(writeID))) {
		int result = new WritingDAO().delete(writeID);
		if(result == 1) {
			session.setAttribute("userID", userID);		
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제가 안료되었습니다.');");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>