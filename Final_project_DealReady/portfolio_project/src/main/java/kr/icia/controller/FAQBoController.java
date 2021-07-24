package kr.icia.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.FAQBoardVO;
import kr.icia.service.FAQBoService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/FAQ/*")
@AllArgsConstructor
public class FAQBoController {
	private FAQBoService faqboservice;

	// 목록
	@GetMapping("/list")
	public void list(Model model) {
		log.info("FAQ list");
		int cnt = faqboservice.totalCnt() + 1;
		model.addAttribute("faq", faqboservice.getList());
		model.addAttribute("cnt", cnt);
	}


	// FAQ 등록폼
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		
	}


	// FAQ 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(FAQBoardVO faq, RedirectAttributes rttr) {
		log.info("register FAQ: " + faq);
		faqboservice.register(faq);
		rttr.addFlashAttribute("result", "success");

		return "redirect:/FAQ/list";
	}


	// 게시글 수정
	@PreAuthorize("principal.username == #writer")
	@RequestMapping(value="/FAQ/modify", method=RequestMethod.POST)
	@ResponseBody
	public boolean modify(String title, String content, Long bno, String writer) {
		FAQBoardVO faq = new FAQBoardVO();
		faq.setTitle(title);
		faq.setContent(content);
		faq.setBno(bno);
		log.info("faq: " + faq);
		boolean data = faqboservice.modify(faq);
		log.info("result: " + data);
		if (data == true) {
			return data;
		} else {
			return data;
		}
	}


	// 게시글 삭제
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno
			, RedirectAttributes rttr, String writer) {
		log.info("remove FAQ num: " + bno);
		if (faqboservice.remove(bno)) {
			rttr.addFlashAttribute("result", "deleted");
		}
		return "redirect:/FAQ/list";
	}

}
