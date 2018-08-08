<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>
<%@ page import="kr.mz.study.mvc1.article.model.Article" %>
<%
	request.setCharacterEncoding("UTF-8");

	ArticleDAO dao = new ArticleDAO();	
	String idx = request.getParameter("idx");
	String isRead = request.getParameter("isRead");
	
	/* 글 한개 select */
	if(idx != "") {
		Article result = dao.getArticleDetail(Integer.parseInt(idx));
		request.setAttribute("result", result);
	}
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<title>MVC1 게시판 폼</title>
</head>
<body>
	<div class="write_wrap">
		<form id="form" method="post" action="#">
			<input type="hidden" name="isNew" value="${param.isNew }">
			<input type="hidden" name="isRead" value="${param.isRead }">
			<input type="hidden" name="idx" value="${param.idx }">
			<table>
				<tr>
					<td>이름</td>
					<td><input type="text" name="user_nm" value="${result.user_nm }"></td>
					<td>비밀번호</td>
					<td><input type="password" name="article_pw" value=""></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><input type="text" name="title" value="${result.title }"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3">
						<textarea cols="50" rows="20" name="content">${result.content }</textarea>
					</td>
				</tr>
			</table>
		</form>
		
		<div id="btn-box">
			<a href="${pageContext.request.contextPath}/form.jsp?idx=${param.idx}" 
			   name="btn-modify">수정</a>
			<input type="button" value="삭제" name="btn-delete">
			<input type="button" value="목록으로" name="btn-cancel">
		</div>
	</div>
	
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath}/js/form.js"></script>
</body>
</html>