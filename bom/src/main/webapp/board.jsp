<%@page import="java.util.Map" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <c:set var="articleList" value="${articleMap.articleList}" />
        <c:set var="cnt" value="${articleMap.totalArticles}" />
        <c:set var="pageSize" value="10" />
        <c:set var="currentPage" value="${articleMap.pageNum}" />
        <% Map articleMap=(Map)request.getAttribute("articleMap"); int
          currentPage=Integer.parseInt(articleMap.get("pageNum").toString()); %>
          <c:set var="section" value="${articleMap.section}" />
          <c:set var="pageNum" value="${articleMap.pageNum}" />
          <!DOCTYPE html>
          <html lang="en">

          <head>
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
            <!-- Script -->
            <script defer src="${contextPath}/assets/js/script.js"></script>
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
                <h1>자유공모 게시판</h1>
                <h3>해당 게시판은 로그인 사용자 누구든 게시물을 업로드 할 수 있습니다. 자신의 작품을 마음껏 뽐내세요.<br>매주 3개 이상의 작품을 선정하여, 홈페이지와 인스타그램 채널에
                  소개합니다.
                </h3>
            </section>
            </div>
            <div id="board-list">
              <div class="container">
                <table class="board-table">
                  <thead>
                    <tr>
                      <th scope="col" class="th-num">번호</th>
                      <th scope="col" class="th-title">제목</th>
                      <th scope="col" class="th-date">글쓴이</th>
                      <th scope="col" class="th-date">좋아요</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:choose>
                      <c:when test="${empty articleList}">
                        <tr>
                          <td colspan="4">공지사항이 없습니다.</td>
                        </tr>
                      </c:when>
                      <c:when test="${!empty articleList}">
                        <c:forEach var="article" items="${articleList}" varStatus="articleNum">
                          <tr>
                            <td>${articleNum.count}</td>
                            <th><a
                                href="${contextPath}/board/viewArticle.do?articleNo=${article.articleNo}">${article.title}</a>
                            </th>
                            <td>${article.writer}</td>
                            <td>
                              <fmt:formatDate value="${article.writeDate}" />
                            </td>
                          </tr>
                        </c:forEach>
                      </c:when>
                    </c:choose>
                  </tbody>
                </table>
                <!-- board seach area -->
                <div id="board-search">
                  <div class="container">
                    <div class="search-window">
                      <form action="${contextPath}/board/search.do" class="search-form" name="searchFrom">
                        <div class="search-wrap">
                          <label for="search" class="blind">공지사항 내용 검색</label>
                          <input id="search" type="search" name="search" placeholder="검색어를 입력해주세요."
                            value="${articleMap.searchKey}">
                          <button type="submit" class="btn btn-dark btn-search" id="search-btn">검색</button>
                        </div>
                        <button type="submit" class="btn btn-dark btn-write"><a
                            href="${contextPath}/board/articleForm.do">글쓰기</button>
                      </form>
                      <a href="${contextPath}/board/listArticles.do"><button type="submit"
                          class="btn btn-dark btn-list">목록</button></a>
                    </div>
                  </div>
                </div>

                <div class="pagination">
                  <ul class="pagination_modal">
                    <!-- 페이징 -->
                    <c:if test="${cnt != 0}">
                      <c:set var="pageCount" value="${cnt / pageSize + (cnt%pageSize==0?0:1)}" />
                      <c:set var="pageBlock" value="10" />
                      <% int startPage=(currentPage-1)/10*10 + 1; %>
                        <c:set var="startPage" value="<%=startPage%>" />
                        <c:set var="endPage" value="${startPage + pageBlock - 1}" />
                        <c:if test="${endPage > pageCount}">
                          <c:set var="endPage" value="${pageCount}" />
                        </c:if>
                        <c:if test="${startPage > pageBlock}">
                          <li class="paging_first"><a class="paging_arrow"
                              href="${contextPath}/board/listArticles.do?section=${section-1}&pageNum=${startPage-pageBlock}&search=${articleMap.searchKey}">
                              << </a>
                          </li>
                        </c:if>

                        <c:forEach var="page" begin="${startPage}" end="${endPage}" step="1">
                          <c:if test="${page == currentPage}">
                            <li class="paging_num paging_active"><a class="num_active"
                                href="${contextPath}/board/listArticles.do?section=${section}&pageNum=${page}&search=${articleMap.searchKey}">${page}</a>
                            </li>
                          </c:if>
                          <c:if test="${page != currentPage}">
                            <li class="paging_num"><a
                                href="${contextPath}/board/listArticles.do?section=${section}&pageNum=${page}&search=${articleMap.searchKey}">${page}</a>
                            </li>
                          </c:if>
                        </c:forEach>

                        <c:if test="${endPage < pageCount}">
                          <li class="paging_last"><a class="paging_arrow"
                              href="${contextPath}/board/listArticles.do?section=${section+1}&pageNum=${startPage+pageBlock}&search=${articleMap.searchKey}">>></a>
                          </li>
                        </c:if>
                    </c:if>
                  </ul>
                </div>
              </div>
            </div>
          </body>

          </html>