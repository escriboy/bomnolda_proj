package bom.board;

import java.sql.Date;

public class ArticleVO {
	private int articleNo;
	private String title;
	private String content;
	private String writer;
	private Date writeDate;
	
	// 생성 
	public ArticleVO() {
		System.out.println("ArticleVO 생성");
	}
	
	public ArticleVO(int articleNo, String title, String content, 
			String writer, Date writeDate) {
		this.articleNo = articleNo;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.writeDate = writeDate;
	}

	public int getArticleNo() {
		return articleNo;
	}

	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	
	
	
}
