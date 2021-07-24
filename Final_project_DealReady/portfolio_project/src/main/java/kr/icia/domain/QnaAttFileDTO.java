package kr.icia.domain;

import lombok.Data;

@Data
public class QnaAttFileDTO {
	private String fileName;	// 파일 이름
	private String uploadPath;	// 저장 위치
	private String uuid;	// 중복되지 않는 구분값(범용 고유 식별자)
	private boolean image;	// 첨부파일이 이미지인지 아닌지 확인
}
