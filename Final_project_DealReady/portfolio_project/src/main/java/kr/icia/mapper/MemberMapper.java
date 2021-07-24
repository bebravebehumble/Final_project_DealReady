package kr.icia.mapper;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.MemJoinVO;

public interface MemberMapper {
	public MemJoinVO login(String userid);	// 로그인

	public String findId(String userMail); 	// 아이디 찾기

	public int findPw(@Param("userid")String userid
			, @Param("userMail") String userMail);	// 비밀번호 찾기

	public int pwMailSend(MemJoinVO memjoin); // 임시 비밀번호 발급
}
