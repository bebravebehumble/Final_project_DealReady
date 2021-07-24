package kr.icia.service;

import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.MemJoinVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class FindAccServiceTests {
	@Setter(onMethod_ = @Autowired)
	private FindAccService service;

	// 아이디 찾기 테스트
//	@Test
//	public void searchIdTest() throws Exception {
//		log.info(service.searchId("test@naver.com"));
//	}


	// 비밀번호 찾기 테스트
//	@Test
//	public void searchPwTest() throws Exception {
//		log.info("pw count result: " + service.searchPw("test4", "test@naver.com"));
//	}


	// 비밀번호 변경 테스트
	@Test
	public void pwMailSendTest() throws Exception {
		MemJoinVO memjoin = new MemJoinVO();
		memjoin.setUserid("pwchangetest");
		memjoin.setUserMail("qlfneef91@naver.com");

		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		uuid = uuid.substring(0, 10);
		memjoin.setUserpw(uuid);

		log.info("update result: " + service.pwMailSend(memjoin));
		log.info("result pw: " + memjoin.getUserpw());
	}

}
