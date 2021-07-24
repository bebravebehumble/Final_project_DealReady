package kr.icia.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaBoardVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QnaBoMapperTests {
	@Setter(onMethod_ = @Autowired)
	private QnaBoMapper mapper;
	
	// mapper getList(목록) 테스트
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
	

	// mapper insertSelectKey(글 작성) 테스트
//	@Test
//	public void testInsertSelectKey() {
//		QnaBoardVO board = new QnaBoardVO();
//		board.setTitle("테스트 제목");
//		board.setContent("테스트 내용");
//		board.setWriter("테스트 작성자");
//		
//		mapper.insertSelectKey(board);
//		log.info(board);
//	}


	// mapper read(글 조회) 테스트
//	@Test
//	public void testRead() {
//		QnaBoardVO board = mapper.read(4L);
//		log.info(board);
//	}


	// mapper delete(글 삭제) 테스트
//	@Test
//	public void testDelete() {
//		log.info("delete cnt: " + mapper.delete(2L));
//	}


	// mapper update(글 수정) 테스트
//	@Test
//	public void testUpdate() {
//		QnaBoardVO board = new QnaBoardVO();
//		board.setBno(3L);
//		board.setTitle("테스트 제목 수정");
//		board.setContent("테스트 내용 수정");
//		board.setWriter("테스트 작성자 수정");
//		
//		int count = mapper.update(board);
//		log.info(count);
//	}
	
	// mapper 페이징 포함 getList(목록) 테스트
	@Test
	public void testGetList2() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(15);
		
		List<QnaBoardVO> list = mapper.getList(cri);
		list.forEach(board -> log.info(board.getBno()));
	}
}
