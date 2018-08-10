<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="kr.mz.study.mvc1.article.dao.ArticleDAO" %>
<%@ page import="kr.mz.study.mvc1.article.model.Article" %>
<%@ page import="java.util.*" %>
<%
	ArticleDAO article = new ArticleDAO();
	
	/** 페이징 08.09 17:30 시작 **/
	//1. 08.10 오전 - 숫자 페이징 완료
	//2. 08.10 오후 - 좌우 블럭이동 완료 (?)
	//2.5 블럭이동 맨 앞뒤로 버튼 없애버리자
	//3. 맨처음, 맨끝이동
	//4. 익셉션처리
	//5. 최종확인
	//6. 소스정리
	//7. 검사받기 -> 수정
	
	
	//url param
	String blockParam = request.getParameter("block");
	String pageParam = request.getParameter("page");
	
	
	// 전체 글 수
	int totalPostCount = article.getListCount();

	// 한 페이지 글 수
	int countPostPerPage = 5;
	
	// 총 페이지수
	double totalPage = Math.ceil((double)totalPostCount / (double)countPostPerPage);
	int totalPageCount = (int)totalPage;
	
	// 선택한 페이지
	int selectPageNum = 1;
	if(pageParam != null) {
		selectPageNum = Integer.parseInt(pageParam);
		/* if(selectPageNum < 1 || selectPageNum > totalPageCount) {
			response.sendRedirect("/mvc1/index.jsp?page=1&block=1");
		} */
	}
	
	// 선택한 페이지 첫번째 글
	int firstPost = countPostPerPage * (selectPageNum - 1);
	if(firstPost < 0) {
		firstPost = 0;
	}
	
	
	
	// 한 블럭당 페이지 수
	int countPagePerBlock = 3;
	
	// 총 블럭 수
	double totalBlock = Math.ceil((double)totalPageCount / (double)countPagePerBlock);
	int totalBlockCount = (int)totalBlock;
	
	// ** 현재 블럭
	int selectBlockNum = 1;	
	if(blockParam != null) {
		selectBlockNum = Integer.parseInt(blockParam);
		System.out.println("in selectBlockNum : " + selectBlockNum);
		//if(selectBlockNum < 1 || selectBlockNum > totalBlockCount) {
			//response.sendRedirect("/mvc1/index.jsp?page=" + selectPageNum + "&block=" + selectBlockNum);
		//}
	}
	
	//** 마지막블럭에서 다음 눌렀을 때 page = +1 됨..
	
	// 선택한 블럭 첫번째 페이지
	int firstPage = countPagePerBlock * (selectBlockNum - 1) + 1;
	
	// 선택한 블럭 마지막 페이지
	int lastPage = countPagePerBlock * selectBlockNum;
	if(lastPage > totalPageCount){
		System.out.println("in lastPage : " + lastPage);
		lastPage = totalPageCount;
	}
	
	// 이전블럭
	int blockPrev = selectBlockNum - 1;
	if(blockPrev <= 1 ) {
		blockPrev = 1;
	}
	
	// 다음블럭
	int blockNext = selectBlockNum + 1;
	if(blockNext >= totalBlockCount) {
		blockNext = totalBlockCount;
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
		
		<div id="page-box">
			<a href="${pageContext.request.contextPath}/index.jsp?page=<%=firstPage-1 %>&block=<%=blockPrev%>">이전</a>
<%			
			for(int i = firstPage; i <= lastPage; i++) {
%>
				<a href="${pageContext.request.contextPath}/index.jsp?page=<%= i %>&block=<%=selectBlockNum%>">
					<%= i %>
				</a>
<%				
			}
%>
			<a href="${pageContext.request.contextPath}/index.jsp?page=<%=lastPage+1 %>&block=<%=blockNext%>">다음</a>
		</div>
	</div>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
</body>
</html>