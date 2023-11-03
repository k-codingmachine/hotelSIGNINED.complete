package com.signied.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class PageVO {
	private int startPage; // 게시글 화면에 보여질 첫번째 번호
	private int endPage; // 게시글 화면에 보여질 마지막 번호
	private boolean prev, next; // 이전, 다음 버튼 활성화 여부
	
	private int pageNum; // 현재 조회하는 페이지번호
	private int amount = 7; // 화면에 보여지는 게시글 개수
	private int total; // 전체게시글 수
	
	public PageVO(int pageNum, int amount, int total) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.total = total;
		
		// 공식 = (int)Math.ceil(페이지번호 / 페이지네이션개수) * 한 페이지에 보여질 게시글 수
		this.endPage = (int)Math.ceil(this.pageNum * 0.14) * 7;
		
		// 시작 페이지 = 끝페이지 - 한 페이지에 보여질 게시글 수 + 1
		this.startPage = this.endPage - 7 + 1;
		
		
		// 진짜 끝 번호 => 혹여나 게시글 수가 딱 떨어지지 않을 수 있으니 realEnd를 구해서 endPage의 값을 다시 설정
		// (int)Math.ceil(전체 게시글 수 / 화면에 보여질 데이터 개수)
		int realEnd = (int)Math.ceil(this.total / (double)this.amount);
		
		
		// 마지막 페이지에 도달했을 때 보여져야 할 끝 번호가 달라진다. 만약 페이지의 수가 10개가 넘어가고
		// 11번 페이지를 클릭했을 때 endPage = 20인데 , realEnd는 전체 게시글 수에 따라 바뀌기 때문에 이때 realEnd로 설정해줘야 한다.
		if(this.endPage > realEnd) {
			this.endPage = realEnd;
		}
		
		// 이전 버튼은 다음 버튼이 생길 때 true
		this.prev = this.startPage > 1;
		
		// 다음 버튼은 endPage가 realEnd보다 작을 때 다음 버튼 활성화
		// 현재 페이지에서 보여지는 endPage최대는 10인데 realEnd가 10보다 크면 다음 버튼 활성화
		this.next = this.endPage < realEnd;
	}
}
