package kr.icia.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;	// 페이징 첫 숫자
	private int endPage;	// 페이징 마지막 숫자
	private int realStart; 	// 첫 페이지
	private int realEnd;	// 마지막 페이지
	private boolean prev, next;	// 이전, 다음
	private int total;	// 총 게시물 개수
	private Criteria cri;	// 현재 페이지, 한 페이지의 게시물 개수
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;	// 전달받은 cri를 필드값 cri에 저장
		this.total = total;	// 전달받은 총 게시물 개수를 필드값 total에 저장
		
		// 페이징 번호 유추
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;	// 한 화면의 마지막 페이징 번호
		this.startPage = this.endPage - 9;	// 한 화면의 첫 페이징 번호
		
		this.realStart = 1;		// 페이지의 첫 번째
		this.realEnd = (int) (Math.ceil((total*1.0) / cri.getAmount()));	// 페이지의 마지막

		// 한 화면의 마지막 페이징 번호가 페이지의 마지막 번호보다 클 때
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		// 이전, 다음 버튼 표시 조건
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
