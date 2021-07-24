package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FAQBoardVO {
	private Long bno;	// FAQ 번호
	private String title;	// FAQ 제목
	private String content;	// FAQ 내용
	private String writer;	// FAQ 작성자
	private Date regDate;	// 등록일
	private Date updateDate;	// 수정일

}
