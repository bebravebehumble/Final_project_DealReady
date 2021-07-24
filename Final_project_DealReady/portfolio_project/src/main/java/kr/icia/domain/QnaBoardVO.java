package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class QnaBoardVO {
	private Long bno;	// 게시물 번호
	private String title;	// 게시물 제목
	private String content;	// 게시물 내용
	private String writer;	// 게시물 작성자
	private Date regdate;	// 등록일
	private Date updateDate;	// 수정일
	private int readCount; 		// 조회수

	private int replyCnt; // 댓글 총 개수
	private List<QnaBoAttachVO> attachList;
	// 여러 개의 첨부파일 등록을 위한 list
	
	
}