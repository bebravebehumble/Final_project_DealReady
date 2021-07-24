package kr.icia.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NotiBoServiceTests {
	@Setter(onMethod_ = @Autowired)
	private NotiBoService notiboservice;

	// 목록 테스트
//	@Test
//	public void getListTest() {
//		notiboservice.getList().forEach(board -> log.info(board));
//	}


	// 작성 테스트
//	@Test
//	public void RegisterTest() {
//		NotiBoardVO noti = new NotiBoardVO();
//		noti.setTitle("ser 작성 테스트0624");
//		noti.setWriter("ser 테스트 작성자0624");
//		noti.setContent("ser 작성 테스트 내용0624");
//
//		notiboservice.register(noti);
//	}


	// 조회 테스트
//	@Test
//	public void getAndRCntTest() {
//		log.info("get notice: " + notiboservice.getAndRCnt(11L));
//	}


	// 수정 테스트
//	@Test
//	public void modifyTest() {
//		NotiBoardVO noti = new NotiBoardVO();
//		noti.setBno(13L);
//		noti.setTitle("공지사항 테스트0624 수정");
//		noti.setContent("공지사항 테스트 내용0624 수정");
//
//		log.info("modify result: " + notiboservice.modify(noti));
//	}


	// 삭제 테스트
	@Test
	public void removeTest() {
		log.info("remove result: " + notiboservice.remove(6L));
	}

}
