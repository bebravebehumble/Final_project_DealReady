package kr.icia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.MemJoinVO;
import kr.icia.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FindAccServiceImp implements FindAccService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper membermapper;

	// 아이디 찾기
	@Override
	public String searchId(String userMail) {
		log.info("search id......" + userMail);
		return membermapper.findId(userMail);
	}

	// 비밀번호 찾기
	@Override
	public int searchPw(String userid, String userMail) {
		log.info("search pw......" + userid);
		return membermapper.findPw(userid, userMail);
	}

	// 임시 비밀번호로 변경
	@Override
	public int pwMailSend(MemJoinVO memjoin) {
		log.info("change pw......" + memjoin);
		return membermapper.pwMailSend(memjoin);
	}

}
