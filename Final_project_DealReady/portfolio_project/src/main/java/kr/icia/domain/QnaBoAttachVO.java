package kr.icia.domain;

import lombok.Data;

@Data
public class QnaBoAttachVO {
	private String uuid;	// 중복되지 않는 고유값
	private String uploadPath;	// 파일 저장 위치
	private String fileName;	// 파일명
	private boolean fileType;	// 파일 타입
	private Long bno;	// 게시물 번호(파일 첨부)

}
