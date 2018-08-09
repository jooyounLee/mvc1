<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>
<%@ page import="kr.mz.study.mvc1.article.model.Article" %>
<%@ page import="java.util.*" %>
<%
	ArticleDAO article = new ArticleDAO();
	List<Article> getList =  article.getArticleList();
	request.setAttribute("articleList", getList);
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/common.css">
<title>MVC1 게시판 리스트</title>
</head>
<body>
	<div class="board_wrap">
		<table>
			<tr>
				<td>No.</td>
				<td>제목</td>
				<td>이름</td>
				<td>작성일</td>
			</tr>
			<c:forEach var="list" items="${articleList }">
				<tr>
					<td>${list.idx}</td>
					<td>
						<a href="${pageContext.request.contextPath}/readForm.jsp?idx=${list.idx}">
							${list.title}
						</a>
					</td>
					<td>${list.user_nm}</td>
					<td>
						<fmt:formatDate value="${list.created }" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</tr>
			</c:forEach>	
		</table>
		<div>
			<a href="${pageContext.request.contextPath}/form.jsp?idx:isnull=true&isNew=true">
				글쓰기
			</a>
		</div>
	</div>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
</body>
</html>