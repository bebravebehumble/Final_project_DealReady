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
public class UserStoreBoMapperTests {
	@Setter(onMethod_ = @Autowired)
	private UserStoreBoMapper ustorebomapper;

	// 상품 업로드 테스트
//	@Test
//	public void uploadPdTest() {
//		UserStoreBoardVO store = new UserStoreBoardVO();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
//		Date date = new Date();
//		String pdDate = sdf.format(date);
//		String p_code = "s" + pdDate;
//		store.setPdId(p_code);
//		store.setPdPrice(8000);
//		store.setPdStock(1);
//		store.setTitle("충전기");
//		store.setContent("5핀 충전기 판매합니다.");
//		store.setWriter("pwchangetest");
//		store.setUserAdd("");
//		ustorebomapper.uploadPd(store);
//		log.info(store);
//	}


	// 목록 테스트
//	@Test
//	public void getListTest() {
//		ustorebomapper.getList().forEach(store -> log.info(store));
//	}


	// 조회 테스트
//	@Test
//	public void readTest() {
//		log.info(ustorebomapper.read(5L));
//	}


	// 수정 테스트
//	@Test
//	public void updateTest() {
//		UserStoreBoardVO store = new UserStoreBoardVO();
//		store.setPno(5L);
//		store.setPdPrice(10000);
//		store.setPdStock(2);
//		store.setTitle("6mb usb");
//		store.setContent("62mb usb 처분합니다.");
//		store.setUserAdd("");
//		ustorebomapper.update(store);
//		log.info(store);
//	}


	// 삭제 테스트
	@Test
	public void deleteTest() {
		log.info("delete Cnt: " + ustorebomapper.delete(""));
	}

}
