<%@page import="java.util.Map" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <!DOCTYPE html>
        <html lang="ko">

        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>Responsive Navigation Bar</title>
          <!-- Font Awesome Icons -->
          <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
          <!-- Fonts -->
          <link rel="stylesheet" as="style" crossorigin
            href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/variable/pretendardvariable-dynamic-subset.css" />
          <!-- Stylesheet -->
          <link rel="stylesheet" href="${contextPath}/assets/css/board.css" />
          <link rel="stylesheet" href="${contextPath}/assets/css/board-view.css">
          <!-- Script -->
          <script defer src="${contextPath}/assets/js/script.js"></script>
          <script>
            function toList() {  //공지사항 목록 보기
              location.href = "${contextPath}/board/listArticles.do";
            }
            function fn_modify(url, articleNo) {  //공지사항 수정
              let form = document.createElement("form");
              form.setAttribute("method", "post");
              form.setAttribute("action", url);
              let articleNoInput = document.createElement("input");
              articleNoInput.setAttribute("type", "hidden");
              articleNoInput.setAttribute("name", "articleNo");
              articleNoInput.setAttribute("value", articleNo);
              form.appendChild(articleNoInput);
              document.body.appendChild(form);
              form.submit();
            }
            function fn_removeNotice(url, articleNo) {  //공지사항 삭제
              let form = document.createElement("form");
              form.setAttribute("method", "post");
              form.setAttribute("action", url);
              let articleNoInput = document.createElement("input");
              articleNoInput.setAttribute("type", "hidden");
              articleNoInput.setAttribute("name", "articleNo");
              articleNoInput.setAttribute("value", articleNo);
              form.appendChild(articleNoInput);
              document.body.appendChild(form);
              form.submit();
            }
          </script>
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
                  <a href="#contact">로그인/회원가입</a>
                </li>
                <li>
                  <a href="#about">자유공모</a>
                </li>
                <li>
                  <a href="#services">자료실</a>
                </li>
                <li>
                  <a href="#team">설명서</a>
                </li>
              </ul>
            </nav>
          </header>
          <section id="home">
            <div class="home_content">
              <h1>작품</h1>
              <h3>${article.title}</h3>
          </section>
          <div class="board_container">
            <div class="content_header">
              <h1>&lt;${article.title}&gt; <a>${article.writer}</a></h1>
              <div>${article.content}</div>
            </div>
          </div>
          <div class="">
            <input type="button" value="글 목록" class="btn_result" onclick="toList()">
          </div>
        </body>

        </html>