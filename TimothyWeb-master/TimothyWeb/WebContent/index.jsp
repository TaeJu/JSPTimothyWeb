<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="writing.WritingDAO" %>
<%@ page import="writing.WritingDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="ride.RideQueue" %>
<!doctype html>
<html>
  <head>
    <title>디모데 웹 사이트</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 부트스트랩 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <!-- 커스텀 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/custom.css">
  </head>
  <body>
 <%
 	request.setCharacterEncoding("UTF-8");
 	String writeType = "전체";
 	String searchType = "최신순";
 	String search = "";
 	int pageNumber = 0;
 	if(request.getParameter("writeType") != null) {
 		writeType = request.getParameter("writeType");
 	}
 	if(request.getParameter("searchType") != null) {
 		searchType = request.getParameter("searchType");
 	}
 	if(request.getParameter("search") != null) {
 		search = request.getParameter("search");
 	}
 	if(request.getParameter("pageNumber") != null) {
 		try {
 			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
 		} catch (Exception e) {
 			System.out.println("검색 페이지 번호 오류");
 		}
 	}
 	String userID = null;
 	if(session.getAttribute("userID") != null) {
 		userID = (String) session.getAttribute("userID");
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
 	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
 	if(emailChecked == false) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("location.href = 'emailSendConfirm.jsp'");
 		script.println("</script>");
 		script.close();
 		return;
 	}
 	LocalDate d = LocalDate.now();
 %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index.jsp">디모데 웹 사이트</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="index.jsp">메인</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
             	 회원 관리
            </a>
            <div class="dropdown-menu" aria-labelledby="dropdown">
 <%
 	if(userID == null) {
 %>
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>
 <% 
 	} else {
 %>             
              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
 <% 
 	}
 %>           
            </div>
          </li>
          <li class="nav-item dropdown">
          	<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
          		목장
          	</a>
          	<div class="dropdown-menu" aria-labelledby="dropdown">
          	  <a class="dropdown-item" href="1MokJang.jsp">1반</a>
              <a class="dropdown-item" href="2MokJang.jsp">2반</a>
              <a class="dropdown-item" href="3MokJang.jsp">3반</a>
              <a class="dropdown-item" href="4MokJang.jsp">4반</a>
              <a class="dropdown-item" href="5MokJang.jsp">5반</a>
              <a class="dropdown-item" href="6MokJang.jsp">6반</a>
              <a class="dropdown-item" href="7MokJang.jsp">7반</a>
              <a class="dropdown-item" href="8MokJang.jsp">8반</a>
              <a class="dropdown-item" href="9MokJang.jsp">9반</a>
              <a class="dropdown-item" href="10MokJang.jsp">10반</a>
          	</div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
             	 라이드
            </a>
            <div class="dropdown-menu" aria-labelledby="dropdown">
              <a class="dropdown-item" href="userRideRequest.jsp">라이드신청/취소</a>
              <a class="dropdown-item" href="userRegisterRider.jsp">라섬이등록</a>
              </div>
          </li>
        </ul>
        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
      </div>
    </nav>
    <div class="container">
    	<form method="get" action="./index.jsp" class="form-inline mt-3">
    		<select name="writeType" class="form-control mx-1 mt-2">
    			<option value="전체">전체</option>
    			<option value="설교" <%if(writeType.equals("설교")) out.println("selected"); %>>설교</option>
    			<option value="질문" <%if(writeType.equals("질문")) out.println("selected"); %>>질문</option>
    			<option value="성경공부" <%if(writeType.equals("성경공부")) out.println("selected"); %>>성경공부</option>
    			<option value="큐티" <%if(writeType.equals("큐티")) out.println("selected"); %>>큐티</option>  			
    		</select>
    		<select name="searchType" class="form-control mx-1 mt-2">
    			<option value="최신순">최신순</option>
    			<option value="공감순" <%if(searchType.equals("공감순")) out.println("selected"); %>>공감순</option>
    		</select>
    		<input type="text" name="search" class="form-control mx-1 mt-2" value="<%= search %>" placeholder="내용을 입력하세요.">
    		<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
    		<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
    		<a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
    	</form>
 <%
 	ArrayList<WritingDTO> writeList = new ArrayList<WritingDTO>();
 	writeList = new WritingDAO().getList(writeType, searchType, search, pageNumber);
 	if(writeList != null)
 		for(int i=0; i < writeList.size(); i++) {
 			if(i==5) break;
 			WritingDTO writing = writeList.get(i);
 %>
    <div class="card bg-light mt-3">
    	<div class="card-header bg-light">
    		<div class="row">
    			<div class="col-8 text-left"><%= writing.getWriteType() %>&nbsp;<small><%= writing.getUserName() %></small></div>
    		</div>
    	</div>
    	<div class="card-body">
    		<h5 class="card-title">
    			<%= writing.getWriteTitle() %>&nbsp;<small><%= d %></small>
    		</h5>
    		<p class="card-text"><%= writing.getWriteContent() %></p>
    		<div class="row">
    			<div class="col-9 text-left">
    				<span style="color: green;">(공감: <%= writing.getLikeCount() %>)</span>
    			</div>
    			<div class="col-3 text-right">
    				<a onclick="retrun confirm('공감하시겠습니까?')" href="./likeAction.jsp?writeID=<%= writing.getWriteID() %>">공감</a>
    				<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?writeID=<%= writing.getWriteID() %>">삭제</a>
    			</div>
    		</div>
    	</div>
    </div>
 <%
 	}
 %>  
    </div>
    <ul class="pagination justify-content-center mt-3">
    	<li class="page-item">
 <%
	if(pageNumber <= 0) {
 %>
 	<a class="page-link disabled">이전</a>
 <%
	} else {
 %>
    <a class="page-link" href="./index.jsp?writeType=<%=URLEncoder.encode(writeType, "UTF-8")%>&searchType=<%= URLEncoder.encode(searchType, "UTF-8")%>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%= pageNumber - 1%>">이전</a>
 <%
	}
 %>
    	</li>
    	<li class="page-item">
 <%
 	if(writeList.size() < 6) {
 %>
 	<a class="page-link disabled">다음</a>
 <%
 	} else {
 %>
 	<a class="page-link" href="./index.jsp?writeType=<%=URLEncoder.encode(writeType, "UTF-8")%>&searchType=<%= URLEncoder.encode(searchType, "UTF-8")%>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%= pageNumber + 1%>">다음</a>
 <%
 	}
 %>
    	</li>
    </ul>
    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    	<div class="modal-dialog">
	    	<div class="modal-content">
	    		<div class="modal-header">
	    			<h5 class="modal-title" id="modal">글 등록</h5>
	    			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	    				<span aria-hidden="true">&times;</span>
	    			</button>
	    		</div>
	    		<div class="modal-body">
	    			<form action="./writeRegisterAction.jsp" method="post">
	    				<div class="form-row">
	    					<div class="form-group col-sm-4">
	    						<label>글분류</label>
	    						<select name="writeType" class="form-control">
	    							<option value="설교">설교</option>
	    							<option value="질문">질문</option>
	    							<option value="성경공부">성경공부</option>
	    							<option value="QT">QT</option>
	    							<option value="기타">기타</option>
	    						</select>
	    					</div>
	    				</div>
	    				<div class="form-row">
	    					<label>제목</label>
	    					<input type="text" name="writeTitle" class="form-control" maxlength="30">
	    				</div>
	    				<div class="form-row">
	    					<label>내용</label>
	    					<textarea type="text" name="writeContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
	    				</div>
	    				<div class="modal-footer">
	    					<button type="button" class="btn btn-secondary" data-dimiss="modal">취소</button>
	    					<button type="submit" class="btn btn-primary">등록하기</button>
	    				</div>
	    			</form>
	    		</div>
	    	</div>
    	</div>
    </div>
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true"">
    	<div class="modal-dialog">
    		<div class="modal-content">
    			<div class="modal-header">
    				<h5 class="modal-title" id="modal">신고하기</h5>
    				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
    					<span aria-hidden="true">&times;</span>
    				</button>
    			</div>
    			<div class="modal-body">
    				<form method="post" action="./reportAction.jsp">
    					<div class="form-group">
    						<label>신고 제목</label>
    						<input type="text" name="reportTitle" class="form-control" maxlength="20">
    					</div>
    					<div class="from-group">
    						<label>신고 내용</label>
    						<textarea type="text" name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
    					</div>
    					<div class="modal-footer">
    						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
    						<button type="submit" class="btn btn-danger">신고하기</button>
    					</div>
    				</form>
    			</div>    		
    		</div>
    	</div>
    </div>
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
    	Copyright @2020 이태주 All Rights Reserved.
    </footer>
    <!-- 제이쿼리 자바스크립트 추가하기 -->
    <script src="./js/jquery.min.js"></script>
    <!-- 파퍼 자바스크립트 추가하기 -->
    <script src="./js/popper.min.js"></script>
    <!-- 부트스트랩 자바스크립트 추가하기 -->
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>