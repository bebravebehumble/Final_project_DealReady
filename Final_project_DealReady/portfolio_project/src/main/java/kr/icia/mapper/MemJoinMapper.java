package kr.icia.mapper;

import kr.icia.domain.MemJoinVO;

public interface MemJoinMapper {
	public void memberJoin(MemJoinVO memjoin);	// 회원가입
	public void memberAuth(String userid);	// 회원가입(권한 추가)

	public int useridCheck(String userid);	// 아이디 중복 검사

}
