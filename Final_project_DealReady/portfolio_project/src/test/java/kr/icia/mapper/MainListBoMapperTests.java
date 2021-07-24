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
public class MainListBoMapperTests {
	@Setter(onMethod_ = @Autowired)
	private MainListBoMapper mainlistbomapper;

	// 모든 사용자 상품 리스트 출력 테스트
	@Test
	public void getMainListTest() {
		mainlistbomapper.getMainList().forEach(store -> log.info(store));
	}

}
