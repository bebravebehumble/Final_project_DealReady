package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NotiBoardVO {
	private Long bno;	// 공지사항 번호
	private String title;	// 공지사항 제목
	private String content;	// 공지사항 내용
	private String writer;	// 공지사항 작성자
	private Date regDate;	// 등록일
	private Date updateDate;	//수정일
	private int readCnt;	// 조회수
	private Integer startNum;	// 목록 시작

}
