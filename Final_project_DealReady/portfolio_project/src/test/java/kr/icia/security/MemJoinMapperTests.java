package kr.icia.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.MemJoinVO;
import kr.icia.mapper.MemJoinMapper;
import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MemJoinMapperTests {
	@Setter(onMethod_ = @Autowired)
	private MemJoinMapper memjoinmapper;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	// 회원가입 테스트
	@Test
	public void memberJoinTest() throws Exception {
		MemJoinVO memjoin = new MemJoinVO();
		
		memjoin.setUserid("addtest1");	// 아이디
		memjoin.setUserpw(pwencoder.encode("addtest1!"));	// 비밀번호
		memjoin.setUserName("addtest1!");	// 이름
		memjoin.setUserNick("addtest1!");	// 닉네임
		memjoin.setUserMail("addtest@naver.com");	// 이메일
		memjoin.setUserAdd("92506");	// 주소
		memjoin.setUserAdd1("경기도 부천시 백현동");
		memjoin.setUserAdd2("백현마을 B동 506호");

		memjoinmapper.memberJoin(memjoin);
	}


	// 아이디 중복 검사
//	@Test
//	public void useridChecl() throws Exception {
//		String id = "admin";
//		String id2 = "aaa123";
//		memjoinmapper.useridCheck(id);
//		memjoinmapper.useridCheck(id2);
//	}
}
