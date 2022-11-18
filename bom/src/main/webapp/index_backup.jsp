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
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${contextPath}/assets/css/main.css" />
	<link rel="stylesheet" href="${contextPath}/assets/css/index.css">
	<script defer src="${contextPath}/assets/js/index.js"></script>
	<noscript>
		<link rel="stylesheet" href="${contextPath}assets/css/noscript.css" />
	</noscript>
	<title>봄놀다</title>
	<c:if test="${msg=='login_failed'}">
		<script type="text/javascript">
			window.onload=function() {
				alert("로그인 정보가 틀립니다.");
			}
		</script>
	</c:if>
</head>

<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
			<div class="inner">

				<!-- Logo -->
				<a href="index.html" class="logo">
					<!-- <span class="symbol"><img src="images/logo.svg" alt="" /></span><span class="title">BOMNOLDA</span> -->
				</a>

				<!-- Nav -->
				<nav>
					<ul>
						<li><a href="#menu">Menu</a></li>
					</ul>
				</nav>

			</div>
		</header>

		<!-- Menu -->
		<nav id="menu">
			<h2>메뉴</h2>
			<ul>
				<li><a href="index.html">홈</a></li>
				<li><a href="generic.html">시리즈</a></li>
				<li><a href="generic.html">자유공모</a></li>
				<li><a href="generic.html">자료실</a></li>
				<li><a href="elements.html">설명서</a></li>
			</ul>

			<ul class="login_area">
				<c:choose>
					<c:when test="${isLogin == true && !empty log_id}">
						<li><a href="#">${name}님</a></li>
						<li><a href="${contextPath}/user/logout.do">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#" class="login show-modal">로그인</a></li>
          				<li><a href="#" class="login show-modal">회원가입</a></li>
					</c:otherwise>
				</c:choose>
				
			</ul>

		</nav>
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

		<!-- Main -->
		<div id="main">
			<div class="inner">
				<header>
					<h1>봄놀다</h1>
					<p>봄놀다는 문학 저작물을 생산하고 저작권을 거래하는 플랫폼이에요.
						누구나 자유롭게 참여할 수 있어요.<br> 봄놀다는 게시물 업로드가 곧 공모에요. 여러분의 글을 마음껏 뽐내주세요.</p>
				</header>
				<section class="tiles">
					<article class="style1">
						<span class="image">
							<img src="${contextPath}/images/pic01.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style2">
						<span class="image">
							<img src="${contextPath}/images/pic02.jpg" alt="DJEL" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style3">
						<span class="image">
							<img src="${contextPath}/images/pic03.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style4">
						<span class="image">
							<img src="${contextPath}/images/pic04.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style5">
						<span class="image">
							<img src="${contextPath}/images/pic05.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style6">
						<span class="image">
							<img src="${contextPath}/images/pic06.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style2">
						<span class="image">
							<img src="${contextPath}/images/pic07.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style3">
						<span class="image">
							<img src="${contextPath}/images/pic08.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style1">
						<span class="image">
							<img src="${contextPath}/images/pic09.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style5">
						<span class="image">
							<img src="${contextPath}/images/pic10.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style6">
						<span class="image">
							<img src="${contextPath}/images/pic11.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
					<article class="style4">
						<span class="image">
							<img src="${contextPath}/images/pic12.jpg" alt="" />
						</span>
						<a href="generic.html">
							<h2>저를 사랑하시거든 물어 물어 길을 찾아오셔요</h2>
							<div class="content">
								<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
							</div>
						</a>
					</article>
				</section>
			</div>
		</div>

		<!-- Footer -->
		<footer id="footer">
			<div class="inner">
				<!-- <section>
					<h2>Get in touch</h2>
					<form method="post" action="#">
						<div class="fields">
							<div class="field half">
								<input type="text" name="name" id="name" placeholder="Name" />
							</div>
							<div class="field half">
								<input type="email" name="email" id="email" placeholder="Email" />
							</div>
							<div class="field">
								<textarea name="message" id="message" placeholder="내용"></textarea>
							</div>
						</div>
						<ul class="actions">
							<li><input type="submit" value="전송" class="primary" /></li>
						</ul>
					</form>
				</section> -->
				<section>
					<h2>Follow</h2>
					<ul class="icons">
						<!-- <li><a href="#" class="icon brands style2 fa-twitter"><span class="label">Twitter</span></a></li> -->
						<!-- <li><a href="#" class="icon brands style2 fa-facebook-f"><span class="label">Facebook</span></a></li> -->
						<li><a href="#" class="icon brands style2 fa-instagram"><span class="label">Instagram</span></a></li>
						<!-- <li><a href="#" class="icon brands style2 fa-dribbble"><span class="label">Dribbble</span></a></li> -->
						<!-- <li><a href="#" class="icon brands style2 fa-github"><span class="label">GitHub</span></a></li> -->
						<!-- <li><a href="#" class="icon brands style2 fa-500px"><span class="label">500px</span></a></li> -->
						<li><a href="#" class="icon solid style2 fa-phone"><span class="label">Phone</span></a></li>
						<li><a href="#" class="icon solid style2 fa-envelope"><span class="label">Email</span></a></li>
					</ul>
				</section>
				<ul class="copyright">
					<li>&copy; 봄놀다. All rights reserved</li>
					<!-- <li>Design: <a href="http://html5up.net">HTML5 UP</a></li> -->
				</ul>
			</div>
		</footer>

	</div>
	<div class="overlay_back hidden"></div>
	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>

</html>