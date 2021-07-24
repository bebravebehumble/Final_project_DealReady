package kr.icia.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QnaBoServiceTests {
	@Setter(onMethod_ = @Autowired)
	private QnaBoService service;

	// 게시판 글 등록 테스트
//	@Test
//	public void testRegister() {
//		QnaBoardVO board = new QnaBoardVO();
//		board.setTitle("service 테스트 제목");
//		board.setContent("service 테스트 내용");
//		board.setWriter("service 테스트 작성자");
//		
//		service.register(board);
//		log.info("생성된 게시물 번호: " + board.getBno());
//	}
	
	// 페이징 포함 목록 테스트
	@Test
	public void testGetList2() {
		service.getList(new Criteria(2, 15)).forEach(board -> log.info(board));
	}
}
