package kr.icia.service;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.MemJoinVO;

public interface FindAccService {
	public String searchId(String userMail); // 아이디 찾기

	public int searchPw(@Param("userid") String userid
			, @Param("userMail") String userMail); // 비밀번호 찾기

	public int pwMailSend(MemJoinVO memjoin);	// 비밀번호 변경
}
