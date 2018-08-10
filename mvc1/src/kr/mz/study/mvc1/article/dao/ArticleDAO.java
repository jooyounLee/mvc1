package kr.mz.study.mvc1.article.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import kr.mz.study.mvc1.article.model.Article;
import kr.mz.study.mvc1.db.DBConn;

public class ArticleDAO {
	
	/**
	 * 총 게시글 수
	 * @return int
	 */
	public int getListCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			String sql = "SELECT COUNT(idx) FROM BOARD WHERE deleted = 0";

			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException sqle) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}
		return result;
	}
	
	/**
	 * 게시판 리스트
	 * @return ArrayList
	 */
	public List<Article> getArticleList(Integer firstPost, Integer countPostPerPage) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<Article> list = new ArrayList<>();
		
		try {
			String sql = "SELECT idx, user_nm, article_pw, title, content, created " + 
					"FROM BOARD WHERE deleted = 0 ORDER BY idx DESC LIMIT ?, ?";

			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, firstPost);
			pstmt.setInt(2, countPostPerPage);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String user_nm = rs.getString("user_nm");
				String article_pw = rs.getString("article_pw");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Date created = rs.getTimestamp("created");
				
				Article dto = new Article(idx, user_nm, article_pw, title, content, created);
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException sqle) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}
		
		return list;
	}
	
	/**
	 * 게시판 글상세보기
	 * @param idx
	 * @return DTO
	 */
	public Article getArticleDetail(Integer idx) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Article dto = null;
		
		try {
			String sql = "SELECT user_nm, article_pw, title, content, created " + 
					"FROM BOARD WHERE idx = ?";
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new Article();
				
				dto.setUser_nm(rs.getString("user_nm"));
				dto.setContent(rs.getString("content"));
				dto.setArticle_pw(rs.getString("article_pw"));
				dto.setTitle(rs.getString("title"));
				dto.setCreated(rs.getDate("created"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException sqle) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}

		return dto;
	}
	
	/**
	 * 게시판 글쓰기
	 * @param title
	 * @param user_nm
	 * @param content
	 * @return int
	 */
	public int createArticle(String article_pw, String title, String user_nm, String content){
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;
		
		try {
			String sql = "INSERT INTO BOARD (user_nm, article_pw, title, content, created, deleted) " + 
					         "VALUES (?, ?, ?, ?, NOW(), 0)";
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nm);
			pstmt.setString(2, article_pw);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}
		
		return result;
	}
	
	/**
	 * 게시글 수정
	 * @param user_nm
	 * @param title
	 * @param content
	 * @param idx
	 * @return int
	 */
	public int modifyArticle(String user_nm, String article_pw, String title, String content, Integer idx){
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;
		
		try {
			String sql = "UPDATE BOARD SET user_nm = ?, article_pw = ?, title = ?, content = ? " + 
							 "WHERE idx = ?";
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_nm);
			pstmt.setString(2, article_pw);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setInt(5, idx);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}
		
		return result;
	}
	
	/**
	 * 게시글 삭제(deleted:1로 update)
	 * @param idx
	 * @return int
	 */
	public int deleteArticle(Integer idx) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;
		
		try {
			String sql = "UPDATE BOARD SET deleted = 1 " + 
							 "WHERE idx = ?";
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}
		
		return result;
	}
	
	/**
	 * 비밀번호 확인 (수정, 삭제시)
	 * @param article_pw
	 * @param idx
	 * @return int
	 */
	public String checkPassword(Integer idx) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		try {
			String sql = "SELECT article_pw FROM BOARD WHERE idx = ?";
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("article_pw");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException sqle) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException sqle) {}
			if(conn != null) try {conn.close();} catch (SQLException sqle) {}
		}
		
		return result;
	}
}
