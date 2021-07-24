package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemJoinVO {
	private String userid;	// 유저 아이디
	private String userpw;	// 유저 비밀번호
	private String userName;	// 유저 이름
	private String userNick;	// 유저 닉네임
	private String userMail;	// 유저 이메일
	private String userAdd;		// 유저 주소
	private String userAdd1;
	private String userAdd2;
	private Date regDate;	// 가입일
	private Date updateDate;	// 정보 수정일
	private int adminCk;	// 관리자 유무
	private boolean enabled;	// 계정 활성화 유무

	private List<AuthVO> authList; // 계정 권한
}
