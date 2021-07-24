package kr.icia.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.FAQBoardVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FAQBoMapperTests {
	@Setter(onMethod_ = @Autowired)
	private FAQBoMapper faqbomapper;

	// FAQ 작성 테스트
//	@Test
//	public void insertFaqTest() {
//		FAQBoardVO faq = new FAQBoardVO();
//		faq.setTitle("양도는 어떻게 해야 하나요?");
//		faq.setWriter("pwchangeTest");
//		faq.setContent("양도 기본 절차입니다. "
//				+ "1. 검색창에 원하는 물품을 입력하신 후 나온 결과에서 마음에 드시는 상품을 고릅니다. "
//				+ "2. 상세 정보를 보신 후, 그대로 구입을 진행하고 싶다면 양도받기, "
//				+ "양도자와 이야기를 나누고 싶다면 1:1 채팅 버튼을 누릅니다."
//				+ "3. 양도를 진행할 시, 택배 또는 직거래를 선택합니다. "
//				+ "4. 택배 선택 시, 배송 받으실 주소와 정보를 입력해 주시고,"
//				+ "직거래 선택 시 만나고자 하는 장소와 당일의 의상착의를 입력하신 뒤 절차대로 진행하시면 됩니다. "
//				+ "모든 양도는 원가 혹은 원가이하로 진행되어야 하며, 프리미엄 적발 시 조취를 취할 예정입니다. "
//				+ "프리미엄 신고와 이외 문의는 1:1 문의 혹은 dealready@nave.com으로 보내주시기 바랍니다. 감사합니다. 딜레디.");

//		faq.setTitle("삭제 테스트");
//		faq.setWriter("삭제 테스트");
//		faq.setContent("삭제 테스트");
//		faqbomapper.insertFaq(faq);
//		log.info("faq: " + faq);
//	}


	// 목록 테스트
//	@Test
//	public void getListTest() {
//		faqbomapper.getList().forEach(faq -> log.info(faq));
//	}


	// 조회 테스트
//	@Test
//	public void readTest() {
//		log.info(faqbomapper.read(1L));
//	}


	// 삭제 테스트
//	@Test
//	public void deleteTest() {
//		log.info("result cnt: " + faqbomapper.delete(2L));
//	}


	// 수정 테스트
	@Test
	public void updateTest() {
		FAQBoardVO faq = new FAQBoardVO();
		faq.setBno(1L);
		faq.setTitle("양도는 어떻게 받아야 하나요?");
		faq.setContent("양수자(양도를 받는 사람) 기본 절차입니다."
				+ "1. 검색창에 원하는 물품을 입력하신 후 나온 결과에서 마음에 드시는 상품을 고릅니다. "
				+ "2. 상세 정보를 보신 후, 그대로 구입을 진행하고 싶다면 양도받기, "
				+ "양도자와 이야기를 나누고 싶다면 1:1 채팅 버튼을 누릅니다."
				+ "3. 양도를 진행할 시, 택배 또는 직거래를 선택합니다. "
				+ "4. 택배 선택 시, 배송 받으실 주소와 정보를 입력해 주시고,"
				+ "직거래 선택 시 만나고자 하는 장소와 당일의 의상착의를 입력하신 뒤 절차대로 진행하시면 됩니다. "
				+ "직거래 시 양수자가 약속된 장소에 나가지 않아 양도자가 피해를 입게 된다면 페널티를 부여할 예정입니다. "
				+ "이점 참고하시길 바랍니다. "
				+ "모든 양도는 원가 혹은 원가 이하로 진행되어야 하며, 프리미엄 적발 시 조치를 취할 예정입니다. "
				+ "프리미엄 신고와 이외 문의는 1:1 문의 혹은 dealready@nave.com으로 보내주시기 바랍니다. 감사합니다. 딜레디.");
		log.info("result cnt: " + faqbomapper.update(faq));
	}

}
