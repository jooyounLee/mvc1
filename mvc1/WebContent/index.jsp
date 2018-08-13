<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	//7. 검사받기
	//8. 수정

	ArticleDAO article = new ArticleDAO();
	
	// param
	String pageParam = request.getParameter("page");
	
	// 전체 글 수
	int totalPostCount = article.getListCount();

	// 한 페이지당 글 수
	int countPostPerPage = 5;
	
	// 총 페이지수
	double totalPage = Math.ceil((double)totalPostCount / (double)countPostPerPage);
	int totalPageCount = (int)totalPage;
	
	// 현재 페이지
	int selectPageNum = 1;
	if(pageParam != null) {
		selectPageNum = Integer.parseInt(pageParam);
	}
	
	// 현재 페이지 첫번째 글
	int firstPost = countPostPerPage * (selectPageNum - 1);
	if(firstPost < 0) {
		firstPost = 0;
	}
	
	// 한 블럭당 페이지 수
	int countPagePerBlock = 3;
	
	// 총 블럭 수
	double totalBlock = Math.ceil((double)totalPageCount / (double)countPagePerBlock);
	int totalBlockCount = (int)totalBlock;
	
	// 현재 블럭
	double selectBlock = Math.ceil((double)selectPageNum / (double)countPagePerBlock);
	int selectBlockNum = (int)selectBlock;	
	
	// 선택한 블럭 첫번째 페이지
	int firstPage = countPagePerBlock * (selectBlockNum - 1) + 1;
	if(firstPage < 1) {
		firstPage = 1;
	}
	
	// 선택한 블럭 마지막 페이지
	int lastPage = countPagePerBlock * selectBlockNum;
	if(lastPage > totalPageCount){
		lastPage = totalPageCount;
	}
	
	// 이전블럭
	int blockPrev = selectBlockNum - 1;
	
	// 다음블럭
	int blockNext = selectBlockNum + 1;
	
	// 이전 페이지
	int pagePrev = firstPage - 1;
	
	// 다음 페이지
	int pageNext = lastPage + 1;
	
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
<%
			if(selectPageNum > 1) {
%>
				<a href="${contextPath}/index.jsp?page=1"> << </a>
<%				
			} else {
%>
				<span> << </span>
<%				
			}
			if(firstPage > 1) {
%>
				<a href="${contextPath}/index.jsp?page=<%=pagePrev %>"> 이전 </a>
<%				
			} else {
%>
				<span>이전</span>
<%
			}
			
			for(int i = firstPage; i <= lastPage; i++) {
				if(i == selectPageNum) {
%>
					<a href="${contextPath}/index.jsp?page=<%= i %>" style="font-size:20px;font-weight:bold;">
						<%= i %>
					</a>
<%				
				} else {
%>
					<a href="${contextPath}/index.jsp?page=<%= i %>">
						<%= i %>
					</a>
<%										
				}
			}
			
			if(lastPage < totalPageCount) {
%>
				<a href="${contextPath}/index.jsp?page=<%=pageNext %>">다음</a>
<%				
			} else {
%>
				<span> 다음 </span>
<%				
			}
			if(selectPageNum < totalPageCount) {
%>
				<a href="${contextPath}/index.jsp?page=<%=totalPageCount %>"> >> </a>
<%			
			} else {
%>
				<span> >> </span>
<%				
			}
%>
		</div>
	</div>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
</body>
</html>