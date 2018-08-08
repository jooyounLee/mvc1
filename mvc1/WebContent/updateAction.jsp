<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	ArticleDAO dao = new ArticleDAO();

	int idx = Integer.parseInt(request.getParameter("idx"));
	String article_pw = request.getParameter("article_pw");
	String title = request.getParameter("title");
	String user_nm = request.getParameter("user_nm");
	String content = request.getParameter("content");
	
	int result = dao.modifyArticle(user_nm, article_pw, title, content, idx);
	request.setAttribute("result", result);
%>

<c:choose>
	<c:when test="${result < 0 }">
		<script>
			alert('글 수정 실패');
			location.href='./index.jsp';
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert('글 수정 완료');
			location.href='./index.jsp';
		</script>
	</c:otherwise>
</c:choose>