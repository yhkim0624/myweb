package com.huation.myweb.common;

import lombok.Data;

@Data
public class ThePager {

	private int pageSize;// 한 페이지당 데이터 개수
	private int pagerSize;// 번호로 보여주는 페이지 Link 개수
	private int dataCount;// 총 데이터 수

	private int pageNo;// 현재 페이지 번호
	private int pageCount;// 총 페이지 수

	public ThePager(int dataCount, int pageNo, int pageSize, int pagerSize) {

		this.dataCount = dataCount;
		this.pageSize = pageSize;
		this.pagerSize = pagerSize;
		this.pageNo = pageNo;
		pageCount = (dataCount / pageSize) + ((dataCount % pageSize) > 0 ? 1 : 0);
	}

	public String toString() {
		StringBuffer linkString = new StringBuffer(2048);

		// 1. 처음, 이전 항목 만들기
		if (pageNo > 1) {
			linkString.append("[<a href='#' id='first'><<</a>]");
			linkString.append("&nbsp;");
		}

		// 2. 페이지 번호 Link 만들기
		int start = pageNo - 2;
		if (start < 1) {
			start = 1;
		}
		int end = start + pagerSize;
		for (int i = start; i < end; i++) {
			if (i > pageCount)
				break;
			linkString.append("&nbsp;");
			if (i == pageNo) {
				linkString.append(String.format("[%d]", i));
			} else {
				linkString.append(String.format("<a href='#' class='numPage'>%d</a>", i));
			}
			linkString.append("&nbsp;");
		}

		// 3. 다음, 마지막 항목 만들기
		if (pageNo < pageCount) {
			linkString.append("&nbsp;");
			linkString.append(String.format("[<a href='#' id='last' data-count='%d'>>></a>]", pageCount));
		}

		return linkString.toString();
	}

}
