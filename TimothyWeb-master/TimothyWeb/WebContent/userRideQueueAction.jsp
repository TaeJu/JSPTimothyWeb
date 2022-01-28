<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="rideQueue.jsp" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userName = null;
	boolean userRideStatus = true;
	int register = 0;
	int cancel = 0;
	int reset = 0;
	int start = 0;
	int requests = 0;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("userName") != null) {
		userName = (String) request.getParameter("userName");
	}
 	if(request.getParameter("register") != null) {
 		try {
 			register = Integer.parseInt(request.getParameter("register"));
 		} catch (Exception e) {
 			System.out.println("오류");
 		}
 	}
 	if(request.getParameter("cancel") != null) {
 		try {
 			cancel = Integer.parseInt(request.getParameter("cancel"));
 		} catch (Exception e) {
 			System.out.println("오류");
 		}
 	}
 	if(request.getParameter("reset") != null) {
 		try {
 			reset = Integer.parseInt(request.getParameter("reset"));
 		} catch (Exception e) {
 			System.out.println("오류");
 		}
 	}
 	if(request.getParameter("start") != null) {
 		try {
 			start = Integer.parseInt(request.getParameter("start"));
 		} catch (Exception e) {
 			System.out.println("오류");
 		}
 	}
 	if(request.getParameter("requests") != null) {
 		try {
 			requests = Integer.parseInt(request.getParameter("requests"));
 		} catch (Exception e) {
 			System.out.println("오류");
 		}
 	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	System.out.println(queue1.getAl().size());
	System.out.println(register);
	System.out.println(cancel);
	if(requests == 5) {
		if(queue1 == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('시스템 오류.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			UserDAO userDAO = new UserDAO();
			if(userDAO.getUserRiderQueueNum(userID) == -1) {
				userDAO.setUserRiderQueueNum(userID, queue1.count);
				String[] requestName = new String[4];
				requestName = queue1.request();
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert(' " + requestName[0] + " " + requestName[1] + " " + requestName[2] + " " + requestName[3] + "');");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			} else {
				String[] requestName = new String[4];
				requestName = queue1.request2(userDAO.getUserRiderQueueNum(userID));
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert(' " + requestName[0] + " " + requestName[1] + " " + requestName[2] + " " + requestName[3] + "');");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			}
		}
	}
	if(start == 4) {
		if(queue1 != null) {
			if(queue1.getAl().size() == 2){
			
			} else {
			queue1.update();
			queue1.fill();
			}
		}
		System.out.println(queue1.getAl().size());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('라이드 서비스 시작 완료.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	if(reset == 3) {
		UserDAO userDAO = new UserDAO();
		userDAO.setUserRideStatusManagerReset();
		userDAO.setUserRiderQueueNumManagerReset();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('리셋 완료.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	if(register == 1) {
		if(queue1 == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('시스템 오류.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			UserDAO userDAO = new UserDAO();
			if(userDAO.getCurrentUserRideStatus(userID) == true) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 라이드 등록을 하셨습니다.');");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			} else {
				String temp = userDAO.getUserName(userID);
				queue1.found = false;
				queue1.addIn(temp);
				queue1.printAll();
				userDAO.setUserRideStatusRegister(userID);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('라이드 등록 성공하셨습니다.');");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			}
		}
	}
	if(cancel == 2) {
		if(queue1 == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('시스템 오류.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			UserDAO userDAO = new UserDAO();
			if(userDAO.getCurrentUserRideStatus(userID) == false) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('취소할 라이드가 없습니다.');");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			} else {
				String temp = userDAO.getUserName(userID);
				queue1.cancelRide(temp);
				queue1.printAll();
				userDAO.setUserRideStatusCancel(userID);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('라이드 취소 성공하셨습니다.');");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			}
		}
	}
%>
