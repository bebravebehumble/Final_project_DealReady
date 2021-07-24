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
public class FAQBoServiceTests {
	@Setter(onMethod_ = @Autowired)
	private FAQBoService faqboservice;

	// 목록 테스트
//	@Test
//	public void getListTest() {
//		faqboservice.getList().forEach(faq -> log.info(faq));
//	}


	// 작성 테스트
//	@Test
//	public void registerTest() {
//		FAQBoardVO faq = new FAQBoardVO();
//		faq.setTitle("삭제 테스트");
//		faq.setWriter("삭제 테스트");
//		faq.setContent("삭제  테스트");
//
//		faqboservice.register(faq);
//		log.info("register: " + faq);
//	}


	// 조회 테스트
//	@Test
//	public void getTest() {
//		log.info("get FAQ: " + faqboservice.get(1L));
//	}


	// 수정 테스트
//	@Test
//	public void modifyTest() {
//		FAQBoardVO faq = new FAQBoardVO();
//		faq.setBno(3L);
//		faq.setTitle("삭제 테스트 수정");
//		faq.setContent("삭제 테스트 수정");
//
//		log.info("modify result: " + faqboservice.modify(faq));
//	}


	// 삭제 테스트
	@Test
	public void removeTest() {
		log.info("delete result: " + faqboservice.remove(3L));
	}

}
