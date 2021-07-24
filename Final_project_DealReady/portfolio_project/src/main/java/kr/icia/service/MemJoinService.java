package kr.icia.service;

import kr.icia.domain.MemJoinVO;

public interface MemJoinService {
	public void memberJoin(MemJoinVO memjoin, String userid) throws Exception; // 회원가입

	public int useridCheck(String userid) throws Exception;	// 아이디 중복 체크

}
