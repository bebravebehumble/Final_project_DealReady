package kr.icia.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QnaReMapperTests {
	// 댓글 테스트를 위한 배열
//	private Long[] bnoArr = { 326L, 327L, 328L, 329L, 330L };

	@Setter(onMethod_ = @Autowired)
	private QnaReMapper mapper;

	// 댓글 등록 테스트
//	@Test
//	public void testCreate() {
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			QnaReplyVO vo = new QnaReplyVO();
//			
//			vo.setBno(bnoArr[i % 5]);
//			vo.setReply("댓글 테스트" + i);
//			vo.setReplyer("replyer" + i);
//			
//			mapper.insert(vo);
//		});
//	}


	// 댓글 페이징 테스트
	@Test
	public void testList2() {
		Criteria cri = new Criteria(3, 5);
		List<QnaReplyVO> replies = mapper.getList(cri, 318L);
		
		replies.forEach(reply -> log.info(reply));
	}

}
