package kr.mz.study.mvc1.util;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class Pagination extends SimpleTagSupport {

	private Integer pageParam;
	
	private String requestURI;

	private Integer totalPostCount;
	
	private Integer countPostPerPage;

	private Integer countPagePerBlock;
	
	private Integer totalPageCount;
	
	private Integer selectPageNum;
	
	private Integer firstPost;
	
	private Integer totalBlockCount;
	
	private Integer selectBlockNum;
	
	private Integer firstPage;
	
	private Integer lastPage;
	
	private Integer pagePrev;
	
	private Integer pageNext;
	
	public String getRequestURI() {
		return requestURI;
	}

	public void setRequestURI(String requestURI) {
		this.requestURI = requestURI;
	}
	
	public Integer getPageParam() {
		return pageParam;
	}

	public void setPageParam(Integer pageParam) {
		this.pageParam = pageParam;
	}

	public Integer getTotalPostCount() {
		return totalPostCount;
	}

	public void setTotalPostCount(Integer totalPostCount) {
		this.totalPostCount = totalPostCount;
	}

	public Integer getCountPostPerPage() {
		return countPostPerPage;
	}

	public void setCountPostPerPage(Integer countPostPerPage) {
		this.countPostPerPage = countPostPerPage;
	}

	public Integer getCountPagePerBlock() {
		return countPagePerBlock;
	}

	public void setCountPagePerBlock(Integer countPagePerBlock) {
		this.countPagePerBlock = countPagePerBlock;
	}

	public Integer getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(Integer totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public Integer getSelectPageNum() {
		return selectPageNum;
	}
	public void setSelectPageNum(Integer selectPageNum) {
		this.selectPageNum = selectPageNum;
	}

	public Integer getFirstPost() {
		return firstPost;
	}

	public void setFirstPost(Integer firstPost) {
		this.firstPost = firstPost;
	}

	public Integer getTotalBlockCount() {
		return totalBlockCount;
	}

	public void setTotalBlockCount(Integer totalBlockCount) {
		this.totalBlockCount = totalBlockCount;
	}

	public Integer getSelectBlockNum() {
		return selectBlockNum;
	}

	public void setSelectBlockNum(Integer selectBlockNum) {
		this.selectBlockNum = selectBlockNum;
	}

	public Integer getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(Integer firstPage) {
		this.firstPage = firstPage;
	}

	public Integer getLastPage() {
		return lastPage;
	}

	public void setLastPage(Integer lastPage) {
		this.lastPage = lastPage;
	}

	public Integer getPagePrev() {
		return pagePrev;
	}

	public void setPagePrev(Integer pagePrev) {
		this.pagePrev = pagePrev;
	}

	public Integer getPageNext() {
		return pageNext;
	}

	public void setPageNext(Integer pageNext) {
		this.pageNext = pageNext;
	}

	@Override
	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		
		// 현재 페이지
		selectPageNum = 1;
		if(pageParam != null) {
			selectPageNum = pageParam;
		}
		
		// 총 페이지수
		double totalPage = Math.ceil((double)totalPostCount / (double)countPostPerPage);
		totalPageCount = (int)totalPage;
		
		// 총 블럭 수
		double totalBlock = Math.ceil((double)totalPageCount / (double)countPagePerBlock);
		totalBlockCount = (int)totalBlock;
		
		// 현재 블럭
		double selectBlock = Math.ceil((double)selectPageNum / (double)countPagePerBlock);
		selectBlockNum = (int)selectBlock;	
		
		// 선택한 블럭 첫번째 페이지
		firstPage = countPagePerBlock * (selectBlockNum - 1) + 1;
		if(firstPage < 1) {
			firstPage = 1;
		}
		
		// 선택한 블럭 마지막 페이지
		lastPage = countPagePerBlock * selectBlockNum;
		if(lastPage > totalPageCount){
			lastPage = totalPageCount;
		}
		
		// 이전 페이지
		pagePrev = firstPage - 1;
		
		// 다음 페이지
		pageNext = lastPage + 1;

		// 페이지 버튼 print
		if(selectPageNum > 1) {
			out.write("<a href=\"" + requestURI + "?page=1\"> << </a>");
		} else {
			out.write("<span> << </span>");
		}
		if(firstPage > 1) {
			out.write("<a href=\"" + requestURI + "?page=" +pagePrev+ " \"> 이전 </a>");
		} else {
			out.write("<span> 이전 </span>");
		}
		
		for(int i = firstPage; i <= lastPage; i++) {
			if(i == selectPageNum) {
				out.write("<a href=\"" + requestURI + "?page=" +i +"\" style=\"font-size:20px;font-weight:bold;\"> " + i + " </a>");
			} else {
				out.write("<a href=\"" + requestURI + "?page=" +i+ "\"> " + i + " </a>");						
			}
		}
		
		if(lastPage < totalPageCount) {
			out.write("<a href=\"" + requestURI + "?page=" +pageNext+ " \"> 다음 </a>");
		} else {
			out.write("<span> 다음 </span>");
		}
		if(selectPageNum < totalPageCount) {
			out.write("<a href=\"" + requestURI + "?page=" +totalPageCount+ " \"> >> </a>");
		} else {
			out.write("<span> >> </span>");	
		}
	}
}
