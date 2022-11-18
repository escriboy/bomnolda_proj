package bom.board;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	
	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			System.out.println("DB 연결 오류");
		}
	}
	// 글 목록 메서드
	public List<ArticleVO> selectAllArticles() {
		List<ArticleVO> articleList=new ArrayList<ArticleVO>();
		try {
			conn = dataFactory.getConnection();
			String query = "SELECT * from boardtbl order by articleNo desc";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int articleNo = rs.getInt("articleNo");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				Date writeDate = rs.getDate("writeDate");
				ArticleVO article = new ArticleVO();
				article.setArticleNo(articleNo);
				article.setTitle(title);
				article.setContent(content);
				article.setWriter(writer);
				article.setWriteDate(writeDate);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("글 목록 조회 중 에러" + e.getMessage());
		}
		return articleList;
	}

	//글 목록 페이지로 나눠서 보기
	public List<ArticleVO> selectAllArticles(Map<String, Integer> pagingMap) {
		List<ArticleVO> articleList=new ArrayList<ArticleVO>();
//		int section=pagingMap.get("section");
		int pageNum=pagingMap.get("pageNum");
		//첫 행 번호를 계산
		int startRow=(pageNum-1)*10+1;
		try {
			conn=dataFactory.getConnection();
			
			String query="select * from (select rownum as recNum, articleno, title, writer, writedate from (select * from boardtbl order by articleno desc)) WHERE recNum BETWEEN ? AND ?";
			
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, startRow+9);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				int articleNo=rs.getInt("articleno");
				String title=rs.getString("title");
				String writer = rs.getString("writer");
				Date writeDate=rs.getDate("writedate");
				ArticleVO article=new ArticleVO();
				article.setArticleNo(articleNo);
				article.setTitle(title);
				article.setWriter(writer);
				article.setWriteDate(writeDate);
				articleList.add(article);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("글 목록 페이징 조회 중 에러 : "+e);
		}
		return articleList;
	}

	//전체 글 개수 조회
	public int selectTotalArticles() {
		int total=0;
		try {
			conn=dataFactory.getConnection();
			String query="select count(articleno) as total from boardtbl";
			pstmt=conn.prepareStatement(query);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				total=rs.getInt("total");				
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("전체 글 개수 조회 중 에러");
		}
		return total;
	}

	//특정 글 상세보기
	public ArticleVO selectArticle(int articleNo) {
		ArticleVO article=new ArticleVO();
		try {
			conn=dataFactory.getConnection();
			String query="select title, content, writedate from boardtbl where articleno=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, articleNo);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			String title=rs.getString("title");
			String content=rs.getString("content");
			Date writeDate=rs.getDate("writedate");
			article.setArticleNo(articleNo);
			article.setTitle(title);
			article.setContent(content);
			article.setWriteDate(writeDate);
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("특정 글 상세보기 중 에러" + e.getMessage());
		}
		return article;
	}
	
		//새 글 작성
	public int insertNewArticle(ArticleVO articleVO) {
		int articleNo = getNewArticleNo();
		try {
			conn = dataFactory.getConnection();
			String query = "insert into boardtbl(articleNo, title, content) values(?,?,?)";
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, articleNo);
			pstmt.setString(2, articleVO.getTitle());
			pstmt.setString(3, articleVO.getContent());
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("글 작성 중 오류" + e.getMessage());
		}
		return articleNo;
	}

	//새 공지사항 작성 시 글번호 생성
	private int getNewArticleNo() {
		try {
			conn = dataFactory.getConnection();
			String query = "select max(articleNo) from boardtbl";
			pstmt=conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return (rs.getInt(1)+1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("글 번호 생성 중 에러" + e.getMessage());
		}
		return 0;
	}

	//공지사항 삭제
	public void deleteArticle(int articleNo) {
		try {
			conn=dataFactory.getConnection();
			String query="delete from boardtbl where articleno=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, articleNo);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("공지사항 삭제 중 에러");
		}
	}

	//공지사항 수정
	public void updateArticle(ArticleVO articleVO) {
		int articleNo=articleVO.getArticleNo();
		String title=articleVO.getTitle();
		String content=articleVO.getContent();		
		try {
			conn=dataFactory.getConnection();
			String query="update boardtbl set title=?, content=? where articleno=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, articleNo);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("공지사항 수정 중 에러");
		}
	}

	//공지사항 검색
	public List<ArticleVO> selectSearchArticles(Map<String, Integer> pagingMap, String searchKey) {
		List<ArticleVO> searchList=new ArrayList<ArticleVO>();
		int pageNum=pagingMap.get("pageNum");
		int startRow=(pageNum-1)*10+1;
		try {
			conn=dataFactory.getConnection();
			String query="SELECT * FROM"
					+ " (SELECT rownum AS recNum, articleno, TITLE, writer, writedate FROM"
					+ " (SELECT * FROM boardtbl WHERE TITLE like ? OR CONTENT like ? ORDER BY articleno DESC))"
					+ " WHERE recNum BETWEEN ? AND ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKey+"%");
			pstmt.setString(2, "%"+searchKey+"%");
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, startRow+9);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				int articleNo=rs.getInt("articleno");
				String title=rs.getString("title");
				String writer = rs.getString("writer");
				Date writeDate=rs.getDate("writedate");
				ArticleVO article=new ArticleVO();
				article.setArticleNo(articleNo);
				article.setTitle(title);
				article.setWriter(writer);
				article.setWriteDate(writeDate);
				searchList.add(article);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("공지사항 검색 중 에러" + e.getMessage());
		}
		return searchList;
	}

	//검색한 게시물 개수
	public int selectTotalSearchArticles(String searchKey) {
		int total=0;
		try {
			conn=dataFactory.getConnection();
			String query="select count(articleno) from boardtbl where title like ? or content like ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKey+"%");
			pstmt.setString(2, "%"+searchKey+"%");
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				total=rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			System.out.println("검색한 공지사항 개수 반환 중 에러" + e.getMessage());
		}
		return total;
	}
}
