package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserStoreBoardVO {
	private Long pno;	// 상품 번호
	private String pdId;	// 상품 id
	private int pdPrice;	// 상품 가격
	private int pdStock;	// 상품 재고
	private String title;	// 업로드 제목
	private String content;	// 업로드 내용
	private String writer;	// 업로드 작성자
	private String userAdd;	// 유저 주소
	private Date regDate;	// 등록일
	private Date updateDate;	// 수정일
	private int readCnt; 		// 조회수
	private String tradingCase; // 거래 방법
	private String state;	// 상품 상태
	private String priceInfo0;	// 배송비 포함
	private String priceInfo1;	// 배송비 별도
	private String priceInfo2;	// 가격 조정 가능

	private List<UserStoreAttachVO> imgList;
	// 여러 개의 첨부파일 등록을 위한 list

}
