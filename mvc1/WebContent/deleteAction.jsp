<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	ArticleDAO dao = new ArticleDAO();

	int idx = Integer.parseInt(request.getParameter("idx"));
	String rePassword = request.getParameter("re-password");
	String originPassword = dao.checkPassword(idx);
	
	if (!rePassword.equals(originPassword)) {
%>
		<script>
			alert("비밀번호를 확인해주세요.");
			history.go(-1);
		</script>
<%		
		return;
	}
	
	int result = dao.deleteArticle(idx);
	request.setAttribute("result", result);
%>

<c:choose>
	<c:when test="${result < 0 }">
		<script>
			alert('삭제 실패');
			location.href='./index.jsp';
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert('삭제 완료');
			location.href='./index.jsp';
		</script>
	</c:otherwise>
</c:choose>