package kr.icia.domain;

import lombok.Data;

@Data
public class UserStoreAttachVO {
	private String pdId;	// 상품 id
	private String uuid;	// uuid
	private String fileName;	// 파일 이름
	private String uploadPath;	// 경로
}
