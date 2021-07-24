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
public class UserStoreBoSeviceTests {
	@Setter(onMethod_ = @Autowired)
	private UserStoreBoService ustoreboservice;

	// 목록 테스트
//	@Test
//	public void getListTest() {
//		ustoreboservice.getList().forEach(store -> log.info(store));
//	}


	// 업로드 테스트
//	@Test
//	public void registerTest() {
//		UserStoreBoardVO store = new UserStoreBoardVO();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//		Date date = new Date();
//		String pdDate = sdf.format(date);
//		String p_code = "s" + pdDate;
//		store.setPdId(p_code);
//		store.setPdPrice(8000);
//		store.setPdStock(1);
//		store.setTitle("액세서리");
//		store.setContent("한 번도 착용한 적 없는 목걸이 판매합니다.");
//		store.setWriter("pwchangetest");
//		store.setUserAdd("");

//		store.setPdPrice(0);
//		store.setPdStock(1);
//		store.setTitle("사탕");
//		store.setContent("사탕 드려요");
//		store.setWriter("pwchangetest");
//		store.setUserAdd("교대역 4번 출구");

//		ustoreboservice.register(store);
//		log.info(store);
//	}


	// 상품 상세페이지 테스트
//	@Test
//	public void getAndCntTest() {
//		log.info(ustoreboservice.getAndCnt(6L));
//	}


	// 상품 수정폼 내용 로딩 테스트
//	@Test
//	public void getTest() {
//		log.info(ustoreboservice.get(7L));
//	}


	// 상품 수정 테스트
//	@Test
//	public void modifyTest() {
//		UserStoreBoardVO store = new UserStoreBoardVO();
//		store.setPno(7L);
//		store.setPdPrice(7500);
//		store.setPdStock(1);
//		store.setTitle("목걸이");
//		store.setContent("착용 안 한 목걸이 원가이하 양도합니다.");
//		store.setUserAdd("삼성역 2번 출구");
//		ustoreboservice.modify(store);
//		log.info(store);
//	}


	// 상품 삭제 테스트
	@Test
	public void removeTest() {
		log.info("remove result: " + ustoreboservice.remove("s20210710165536034"));
	}

}
