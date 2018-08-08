package kr.mz.study.mvc1.article.model;

import java.sql.Timestamp;

public class Article {
	private int idx;
	private String user_nm;
	private String article_pw;
	private String title;
	private String content;
	private Timestamp created;
	
	
	public Article() {}
	
	public Article(int idx, String user_nm, String article_pw, String title, String content, Timestamp created) {
		super();
		this.idx = idx;
		this.user_nm = user_nm;
		this.article_pw = article_pw;
		this.title = title;
		this.content = content;
		this.created = created;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public Timestamp getCreated() {
		return created;
	}
	public void setCreated(Timestamp created) {
		this.created = created;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getArticle_pw() {
		return article_pw;
	}
	public void setArticle_pw(String article_pw) {
		this.article_pw = article_pw;
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
	
	
}
