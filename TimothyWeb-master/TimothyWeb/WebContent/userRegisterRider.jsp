<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('로그인을 해주세요.)");
 		script.println("location.href = 'index.jsp'");
 		script.println("</script>");
 		script.close();
 		return;
	}
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
    <div class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userRegisterRiderAction.jsp">
			<button type="submit" class="btn btn-primary">라섬이로 등록하기</button>
		</form>
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