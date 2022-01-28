<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="writing.WritingDTO"%>
<%@ page import="writing.WritingDAO"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
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
	String userName = null;
	String writeTitle = null;
	String writeType = null;
	String writeContent = null;
	UserDAO userDAO = new UserDAO();
	userName = userDAO.getUserName(userID);
	if(request.getParameter("writeTitle") != null) {
		writeTitle = (String) request.getParameter("writeTitle");
	}
	if(request.getParameter("writeType") != null) {
		writeType = (String) request.getParameter("writeType");
	}
	if(request.getParameter("writeContent") != null) {
		writeContent = (String) request.getParameter("writeContent");
	}
	System.out.println(userName);
	if(writeTitle == null || writeType == null || writeContent == null || writeTitle.equals("") || writeContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		WritingDAO writingDAO = new WritingDAO();
		int result = writingDAO.write(new WritingDTO(0, userID, userName, writeTitle, writeType, writeContent, 0));
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 등록에 실패했습니다');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='./index.jsp';");
			script.println("</script>");
			script.close();
			return;
		}
	}
%>