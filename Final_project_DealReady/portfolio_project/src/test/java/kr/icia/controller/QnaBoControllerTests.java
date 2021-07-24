package kr.icia.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
@WebAppConfiguration
public class QnaBoControllerTests {
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	// url이 /qnaBoard/list일 때 목록 테스트
//	@Test
//	public void testList() throws Exception {
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/qnaBoard/list"))
//				.andReturn().getModelAndView().getModelMap());
//	}

	// url이 /qnaBoard/register일 때 글 작성 테스트
//	@Test
//	public void testRegister() throws Exception {
//		String result = mockMvc.perform(MockMvcRequestBuilders.post("/qnaBoard/register")
//				.param("title", "register 테스트 제목")
//				.param("content", "register 테스트 내용")
//				.param("writer", "register 테스트 작성자"))
//				.andReturn().getModelAndView().getViewName();
//		log.info(result);
//	}
	
	// url이 url이 /qnaBoard/get일 때 글 조회 테스트
//	@Test
//	public void testGet() throws Exception {
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/qnaBoard/get").param("bno",  "6"))
//				.andReturn().getModelAndView().getModelMap());
//	}
	
	// url이 /qnaBoard/modify일 때 글 수정 테스트
//	@Test
//	public void testModify() throws Exception {
//		String result = mockMvc.perform(MockMvcRequestBuilders.post("/qnaBoard/modify")
//				.param("bno", "6")
//				.param("title", "modify 테스트 수정 제목")
//				.param("content", "modify 테스트 수정 내용")
//				.param("writer", "modify 테스트 수정 작성자"))
//				.andReturn().getModelAndView().getViewName();
//		
//		log.info(result);
//	}
	
	// url이 /qnaBoard/remove일 때 글 삭제 테스트
//	@Test
//	public void testRemove() throws Exception {
//		String result = mockMvc.perform(MockMvcRequestBuilders.post("/qnaBoard/remove")
//				.param("bno", "1")).andReturn().getModelAndView().getViewName();
//		log.info(result);
//	}
	
	// url이 /qnaBoard/list일 때 페이징 처리된 목록 테스트
//	@Test
//	public void testList2() throws Exception {
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/qnaBoard/list")
//				.param("pageNum", "3").param("amount", "15"))
//				.andReturn().getModelAndView().getModelMap());
//	}
	
	// url이 /qnaBord/list일 때 검색 결과 테스트
	@Test
	public void testList3() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/qnaBoard/list")
				.param("pageNum", "7").param("amount", "15")
				.param("type", "T").param("keyword", "수정"))
				.andReturn().getModelAndView().getModelMap());
	}
}
