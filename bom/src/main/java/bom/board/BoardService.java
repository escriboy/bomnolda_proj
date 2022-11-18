package bom.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardService {
	BoardDAO boardDAO;
	
	public BoardService() {
		boardDAO = new BoardDAO();
	}
	
	public List<ArticleVO> listArticles() {
		List<ArticleVO> articleList = boardDAO.selectAllArticles();
		return articleList;
	}

	public Map listArticles(Map<String, Integer> pagingMap) {
		Map articleMap=new HashMap();
		List<ArticleVO> articleList=boardDAO.selectAllArticles(pagingMap);
		int totalArticles=boardDAO.selectTotalArticles();
		articleMap.put("articleList", articleList);
		articleMap.put("totalArticles", totalArticles);
		return articleMap;
	}	

		public ArticleVO viewArticle(int articleNo) {
		ArticleVO article=null;
		article=boardDAO.selectArticle(articleNo);
		return article;
	}
	
	public int addArticle(ArticleVO articleVO) {
		int articleNo = boardDAO.insertNewArticle(articleVO);
		return articleNo;
	}

	public void removeArticle(int articleNo) {
		boardDAO.deleteArticle(articleNo);
	}

	public ArticleVO findArticle(int articleNo) {
		ArticleVO article=boardDAO.selectArticle(articleNo);
		return article;
	}

	public void modArticle(ArticleVO articleVO) {
		boardDAO.updateArticle(articleVO);
	}

		public Map listSearch(Map<String, Integer> pagingMap, String searchKey) {
		Map articleMap=new HashMap();
		List<ArticleVO> searchList=boardDAO.selectSearchArticles(pagingMap, searchKey);
		int totalSearchArticles=boardDAO.selectTotalSearchArticles(searchKey);
		articleMap.put("articleList", searchList);
		articleMap.put("totalArticles", totalSearchArticles);
		return articleMap;
	}

}
