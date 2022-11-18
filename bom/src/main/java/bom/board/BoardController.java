package bom.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/board/*")
public class BoardController extends HttpServlet {
	BoardService boardService;
	ArticleVO articleVO;
	
	public void init(ServletConfig config) throws ServletException {
		boardService = new BoardService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = "";
		PrintWriter pw;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("요청매핑이름:"+ action);
		try {
			List<ArticleVO> articleList = new ArrayList<ArticleVO>();
			if(action.equals("/search.do")) {  //공지사항 검색
				String searchKey=request.getParameter("search");  //검색할 키워드
				if(searchKey != null && searchKey.length() != 0) {
					String _section=request.getParameter("section");
					String _pageNum=request.getParameter("pageNum");
					int section=Integer.parseInt((_section == null)?"1":_section);
					int pageNum=Integer.parseInt((_pageNum == null)?"1":_pageNum);
					Map<String, Integer> pagingMap=new HashMap<String, Integer>();
					pagingMap.put("section", section);
					pagingMap.put("pageNum", pageNum);  //페이징 관련
					Map articleMap=boardService.listSearch(pagingMap, searchKey);
					articleMap.put("section", section);
					articleMap.put("pageNum", pageNum);
					articleMap.put("searchKey", searchKey);
					request.setAttribute("articleMap", articleMap);
					nextPage="/board.jsp";					
				}else {
					nextPage="/board/listArticles.do";
				}
			// if(action == null) {
			// 	articleList = boardService.listArticles();
			// 	request.setAttribute("articleList", articleList);
			// 	nextPage = "/board.jsp";
			} else if(action.equals("/listArticles.do")) {
				String searchKey=request.getParameter("search");
				if(searchKey == null || searchKey.length() == 0) {
					String _section=request.getParameter("section");
					String _pageNum=request.getParameter("pageNum");
					int section=Integer.parseInt((_section == null)?"1":_section);
					int pageNum=Integer.parseInt((_pageNum == null)?"1":_pageNum);
					Map<String, Integer> pagingMap=new HashMap<String, Integer>();
					pagingMap.put("section", section);
					pagingMap.put("pageNum", pageNum);
					Map articleMap=boardService.listArticles(pagingMap);
					articleMap.put("section", section);
					articleMap.put("pageNum", pageNum);
					request.setAttribute("articleMap", articleMap);
					nextPage="/board.jsp";					
				}else {
					nextPage="/board/search.do";
				}
				// articleList = boardService.listArticles();
				// request.setAttribute("articleList", articleList);
				// nextPage = "/board.jsp";
			} else if(action.equals("/articleForm.do")) {
				nextPage = "/articleForm.jsp";
			} else if(action.equals("/viewArticle.do")) {  //글제목 클릭 시 공지사항 상세 보기
				int articleNo=Integer.parseInt(request.getParameter("articleNo"));
				articleVO=boardService.viewArticle(articleNo);
				request.setAttribute("article", articleVO);
				nextPage="/board_detail.jsp";
			} else if(action.equals("/addArticle.do")) {
				int articleNo =0;
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				articleVO.setTitle(title);
				articleVO.setContent(content);
				articleNo=boardService.addArticle(articleVO);
				pw=response.getWriter();
				pw.print("<script>"
						+ "alert('공지사항을 작성했습니다.');"
						+ "location.href='" + request.getContextPath() + "/board/viewArticle.jsp?articleNo=" + articleNo + "';"
						+ "</script>");
				return;
			}else if(action.equals("/removeArticle.do")) {
				int articleNo=Integer.parseInt(request.getParameter("articleNo"));
				boardService.removeArticle(articleNo);
				pw=response.getWriter();
				pw.print("<script>"
						+ "alert('공지사항이 삭제되었습니다.');"
						+ "location.href='" + request.getContextPath() + "/board/listArticles.do';"
						+ "</script>");
				return;
			} else if(action.equals("/modArticleForm.do")) {
				int articleNo=Integer.parseInt(request.getParameter("articleNo"));
				articleVO=boardService.findArticle(articleNo);
				request.setAttribute("article", articleVO);
				nextPage="/board_modForm.jsp";
			}else if(action.equals("/modArticle.do")) {
				int articleNo=Integer.parseInt(request.getParameter("articleNo"));
				String title=request.getParameter("title");
				String content=request.getParameter("content");
				articleVO.setArticleNo(articleNo);
				articleVO.setTitle(title);
				articleVO.setContent(content);
				boardService.modArticle(articleVO);
				pw=response.getWriter();
				pw.print("<script>"
						+ "alert('공지사항이 수정되었습니다.');"
						+ "location.href='" + request.getContextPath() + "/board/viewArticle.do?articleNo=" + articleNo + "';"
						+ "</script>");
				return;
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
			dispatcher.forward(request, response); // 글 목록 포워딩 요청
		} catch (Exception e) {
			System.out.println("글 불러오기 중 오류" + e.getMessage());
		}
	}

}
