package kr.icia.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//@Log4j
public class UstoreBoAttachMapperTests {
	@Setter(onMethod_ = @Autowired)
	private UstoreBoAttachMapper ustoreboattachmapper;

	// 업로드 테스트
//	@Test
//	public void uploadImgTest() {
//		UserStoreAttachVO image = new UserStoreAttachVO();
//		image.setPdId("s20210708182004.887_null");
//		image.setUuid("uuid2");
//		image.setFileName("fileName2");
//		image.setUploadPath("2021\\07\\10");
//		ustoreboattachmapper.uploadImg(image);
//		log.info("upload image: " + image);
//	}

	// 목록 테스트
//	@Test
//	public void imgListTest() {
//		log.info(ustoreboattachmapper.imgList("s20210708182004.887_null"));
//	}

	// 삭제 테스트
	@Test
	public void deleteTest() {
		ustoreboattachmapper.delete("uuid1");
	}

}
