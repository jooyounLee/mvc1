<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>
<%@ page import="kr.mz.study.mvc1.article.model.Article" %>
<%
	request.setCharacterEncoding("UTF-8");

	ArticleDAO dao = new ArticleDAO();	
	String idx = request.getParameter("idx");
	
	/* 글 한개 select */
	if(idx != null) {
		Article result = dao.getArticleDetail(Integer.parseInt(idx));
		request.setAttribute("result", result);
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/common.css">
<title>MVC1 게시판 글 상세</title>
</head>
<body>
	<div id="read_wrap">
	
		<form id="form-read" method="post" action="#">
			<input type="hidden" name="idx" value="${param.idx }">
			<table>
				<tr>
					<td>이름</td>
					<td>${result.user_nm }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${result.title }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						${result.content }
					</td>
				</tr>
			</table>
			
			<div id="btn-box-read">
				<input type="password" name="re-password" placeholder="수정/삭제 비밀번호 입력">
				<input type="button" name="btn-modify" value="수정">
				<input type="button" name="btn-delete" value="삭제">
				<input type="button" name="btn-cancel" value="목록으로">
			</div>
			
		</form>
	</div>
	
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath}/js/article.js"></script>
</body>
</html>