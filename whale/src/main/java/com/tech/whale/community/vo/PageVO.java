package com.tech.whale.community.vo;

public class PageVO {
	private Integer displayRowCount = 5;  // 출력할 데이터 갯수
	private Integer rowStart;  			// 시작행 번호
	private Integer rowEnd;  			// 종료행 번호
	private Integer totPage; 			 // 전체페이지 수
	private Integer totRow = 0; 			 // 전체 데이터 수
	private Integer page; 			 	// 현재페이지
	private Integer pageStart; 			 // 시작페이지
	private Integer pageEnd; 			 // 종료페이지
	private Integer pageGrpCnt = 5; 	// 패이지 그룹의 페이지개수
	
	
//	전체데이터 갯수를 이용해서 페이지 계산
	public void pageCalculate(Integer total) {
		getPage();
		totRow = total;
		totPage = (int)(total / displayRowCount);
		if (total % displayRowCount > 0) {
			totPage++;
		} // 여기까지가 삼항연산자 표현한 것
		pageStart = (page - (page - 1) % displayRowCount);
		pageEnd = pageStart + 4;

//		제일 마지막 페이지 그룹에서는 설정한 페이지그룹 수만큼 안나올 수 있기 때문에
		if (pageEnd > totPage) {
			pageEnd = totPage;
		}
		
		rowStart = ((page - 1) * displayRowCount) + 1;
		rowEnd = rowStart + displayRowCount - 1;
	}

	public Integer getPage() {
		if (page == null || page == 0) {
			page = 1;
		}
		return page;
	}


	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getDisplayRowCount() {
		return displayRowCount;
	}

	public void setDisplayRowCount(Integer displayRowCount) {
		this.displayRowCount = displayRowCount;
	}

	public Integer getRowStart() {
		return rowStart;
	}

	public void setRowStart(Integer rowStart) {
		this.rowStart = rowStart;
	}

	public Integer getRowEnd() {
		return rowEnd;
	}

	public void setRowEnd(Integer rowEnd) {
		this.rowEnd = rowEnd;
	}

	public Integer getTotPage() {
		return totPage;
	}

	public void setTotPage(Integer totPage) {
		this.totPage = totPage;
	}

	public Integer getTotRow() {
		return totRow;
	}

	public void setTotRow(Integer totRow) {
		this.totRow = totRow;
	}

	public Integer getPageStart() {
		return pageStart;
	}

	public void setPageStart(Integer pageStart) {
		this.pageStart = pageStart;
	}

	public Integer getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(Integer pageEnd) {
		this.pageEnd = pageEnd;
	}


}
