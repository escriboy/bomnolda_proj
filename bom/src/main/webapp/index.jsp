<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
    <%
    	request.setCharacterEncoding("UTF-8");
    	String name = request.getParameter("name");
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Responsive Navigation Bar</title>
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
  <!-- Fonts -->
  <link rel="stylesheet" as="style" crossorigin
    href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/variable/pretendardvariable-dynamic-subset.css" />
  <!-- Stylesheet -->
  <link rel="stylesheet" href="${contextPath}/assets/css/style.css" />
  <link rel="stylesheet" href="${contextPath}/assets/css/index.css" />
    <!-- Script -->
  <script defer src="${contextPath}/assets/js/script.js"></script>
  <script defer src="${contextPath}/assets/js/index.js"></script>
</head>

<body>
  <header>
    <nav>
      <a href="#home" id="logo">봄놀다</a>
      <i class="fas fa-bars" id="ham-menu"></i>
      <ul id="nav-bar">
        <li>
          <a href="#home">홈</a>
        </li>
        <li>
          <a href="${contextPath}/board/listArticles.do">자유공모</a>
        </li>
        <li>
          <a href="#services">자료실</a>
        </li>
        <li>
          <a href="#team">설명서</a>
        </li>
        <c:choose>
					<c:when test="${isLogin == true && !empty log_id}">
						<li><a href="#">${name}님</a></li>
						<li><a href="${contextPath}/user/logout.do">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#contact" class="login show-modal">로그인/회원가입</a></li>
					</c:otherwise>
		</c:choose>
      </ul>
    </nav>
  </header>

  <section id="home">
    <h1>Home Section</h1>
  </section>
  <div class="cards">
    <div class="card card1">
      <div class="container">
        <img src="${contextPath}/assets/images/vegas.jpg" alt="las vegas">
      </div>
      <div class="details">
        <h3>Las Vegas</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium dignissimos, minus aperiam adipisci
          exercitationem.</p>
      </div>
    </div>
    <div class="card card2">
      <div class="container">
        <img src="${contextPath}/assets/images/newyork.jpg" alt="New York">
      </div>
      <div class="details">
        <h3>New York</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium dignissimos, minus aperiam adipisci
          exercitationem.</p>
      </div>
    </div>
    <div class="card card3">
      <div class="container">
        <img src="${contextPath}/assets/images/singapore.jpg" alt="Singapore">
      </div>
      <div class="details">
        <h3>Singapore</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium dignissimos, minus aperiam adipisci
          exercitationem.</p>
      </div>
    </div>
    <div class="card card1">
      <div class="container">
        <img src="${contextPath}/assets/images/vegas.jpg" alt="las vegas">
      </div>
      <div class="details">
        <h3>Las Vegas</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium dignissimos, minus aperiam adipisci
          exercitationem.</p>
      </div>
    </div>
    <div class="card card2">
      <div class="container">
        <img src="${contextPath}/assets/images/newyork.jpg" alt="New York">
      </div>
      <div class="details">
        <h3>New York</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium dignissimos, minus aperiam adipisci
          exercitationem.</p>
      </div>
    </div>
    <div class="card card3">
      <div class="container">
        <img src="${contextPath}/assets/images/singapore.jpg" alt="Singapore">
      </div>
      <div class="details">
        <h3>Singapore</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium dignissimos, minus aperiam adipisci
          exercitationem.</p>
      </div>
    </div>
  </div>
  <div class="login_section hidden modal">
        <div class="login_form_cont" id="login_form_cont">
          <div class="form-container sign-up-container">
            <form method="post" action="${contextPath}/user/join.do">
              <h1>회원가입</h1>
              <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>

              </div>
              <span>이메일로 가입하기</span>
              <input type="text" placeholder="이름" name="name" />
              <input type="email" placeholder="이메일" name="id" />
              <input type="password" placeholder="비밀번호" name="pwd"/>
              <button type="submit">회원가입</button>
            </form>
          </div>
          <div class="form-container sign-in-container">
            <form method="post" class="login_form" name="frmLogin" action="${contextPath}/user/login.do">
              <h1>로그인</h1>
              <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>

              </div>
              <span>이메일로 로그인</span>
              <input type="email" placeholder="이메일" name="id"/>
              <input type="password" placeholder="비밀번호" name="pwd"/>
              <a href="#">비밀번호를 잊으셨나요?</a>
              <button type="submit" class="form-control">로그인</button>
            </form>
          </div>
          <div class="overlay-container">
            <div class="overlay">
              <div class="overlay-panel overlay-left">
                <h1>로그인하기</h1>
                <p>이미 아이디가 있으신가요? 🙂</p>
                <button class="ghost" id="signIn">로그인하기</button>
              </div>
              <div class="overlay-panel overlay-right">
                <h1>회원가입하기</h1>
                <p>봄놀다의 다양한 혜택을 누려보세요😆</p>
                <button class="ghost" id="signUp">회원가입하기</button>
              </div>
            </div>
          </div>
        </div>
      </div>
</body>

</html>