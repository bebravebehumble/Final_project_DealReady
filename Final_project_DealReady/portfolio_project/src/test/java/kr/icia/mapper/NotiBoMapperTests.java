package kr.icia.mapper;

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
public class NotiBoMapperTests {
	@Setter(onMethod_ = @Autowired)
	private NotiBoMapper notibomapper;

	// 공지사항 작성 테스트
//	@Test
//	public void insertNotiTest() {
//		NotiBoardVO noti = new NotiBoardVO();
//		noti.setTitle("공지사항 테스트0624");
//		noti.setWriter("테스트 작성자0624");
//		noti.setContent("공지사항 테스트 내용0624");
//
//		notibomapper.insertNoti(noti);
//		log.info("recode: " + noti);
//	}


	// 목록 테스트
//	@Test
//	public void getListTest() {
//		notibomapper.getList().forEach(board -> log.info(board));
//	}


	// 조회 테스트
//	@Test
//	public void readTest() {
//		log.info(notibomapper.read(3L));
//	}


	// 삭제 테스트
//	@Test
//	public void deleteTest() {
//		log.info("delete cnt: " + notibomapper.delete(9L));
//	}


	// 수정 테스트
//	@Test
//	public void updateTest() {
//		NotiBoardVO noti = new NotiBoardVO();
//		noti.setBno(10L);
//		noti.setTitle("공지사항 테스트입니다1 수정");
//		noti.setContent("공지사항 테스트입니다 내용1 수정");
//
//		log.info("update cnt: " + notibomapper.update(noti));
//	}


	// 게시물 개수 테스트
	@Test
	public void totalCntTest() {
		log.info("totalCnt: " + notibomapper.totalCnt());
	}

}
