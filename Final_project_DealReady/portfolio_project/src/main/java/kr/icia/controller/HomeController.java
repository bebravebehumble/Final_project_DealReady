package kr.icia.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.icia.domain.UserStoreBoardVO;
import kr.icia.service.MainListBoService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class HomeController {
	@Setter(onMethod_ = @Autowired)
	private MainListBoService mainlistboservice;

	// 메인 화면(딜레디몰)
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String mainPage(Model model) {
		log.info("get main list......");
		List<UserStoreBoardVO> store = mainlistboservice.getMainList();
		int cnt = store.size();
		log.info("총 개수" + cnt);
		model.addAttribute("store", store);
		model.addAttribute("cnt", cnt);
		model.addAttribute("num", cnt);

		return "home";
	}
}
