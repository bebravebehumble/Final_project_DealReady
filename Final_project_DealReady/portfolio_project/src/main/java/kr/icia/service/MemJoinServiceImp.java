package kr.icia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.MemJoinVO;
import kr.icia.mapper.MemJoinMapper;
import lombok.Setter;

@Service
public class MemJoinServiceImp implements MemJoinService {
	@Setter(onMethod_ = @Autowired)
	private MemJoinMapper memjoinmapper;

	// 회원가입
	@Override
	public void memberJoin(MemJoinVO memjoin, String userid) throws Exception {
			memjoinmapper.memberJoin(memjoin);
			memjoinmapper.memberAuth(userid);
	}

	// 아이디 중복 체크
	@Override
	public int useridCheck(String userid) throws Exception {
		return memjoinmapper.useridCheck(userid);
	}

}
