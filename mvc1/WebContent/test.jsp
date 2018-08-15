<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="jooy" uri="/tlds/pagination"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>
<%@ page import="java.util.*" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%

	/** 페이징 08.09 17:30 시작 **/
	//1. 08.10 - 숫자 페이징 완료
	//2. 08.10 - 좌우 블럭이동 완료 
	//3. 08.13 - 블럭이동 맨 앞뒤로 버튼 없애버리자 완료
	//4. 08.13 - 맨처음, 맨끝이동 완료
	//5. 08.13 - 최종확인
	//6. 08.13 - 소스정리
	//7. 08.13 - 검사받기
	//8. 수정
	//		: 현재블럭 계산해서 사용하기(완)
	//		: 현재페이지 표시(완)
	//		: 이전, 다음 span(완)
	//		: 커스텀 태그로 만들기(작업중...)

	ArticleDAO article = new ArticleDAO();
	
	// 전체 글 수--
	int totalPostCount = article.getListCount();

	// 한 페이지당 글 수--
	int countPostPerPage = 5;
	
	// 한 블럭당 페이지 수--
	int countPagePerBlock = 3;
	
	// page parameter
	String pageParam = request.getParameter("page");
	int selectPageNum = 1;
	if(pageParam != null) {
		selectPageNum = Integer.parseInt(pageParam);
	}	
	
	// 페이지 첫번째 글
	int firstPost = countPostPerPage * (selectPageNum - 1);
	if(firstPost < 0) {
		firstPost = 0;
	}
	
	// 게시물 리스트 get
	request.setAttribute("articleList", article.getArticleList(firstPost, countPostPerPage));
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
						<a href="${contextPath}/readForm.jsp?idx=${list.idx}">
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
			<a href="${contextPath}/form.jsp?idx:isnull=true&isNew=true">
				글쓰기
			</a>
		</div>
		
		<div id="page-box">
			<jooy:paging pageParam="<%=selectPageNum %>" 
						 requestURI="<%=request.getRequestURI() %>" 
						 totalPostCount="<%=totalPostCount %>" 
						 countPostPerPage="<%=countPostPerPage %>" 
						 countPagePerBlock="<%=countPagePerBlock %>"/>
		</div>
	</div>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
</body>
</html>