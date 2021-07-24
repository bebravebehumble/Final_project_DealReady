package kr.icia.controller;

import java.util.List;

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

import kr.icia.domain.NotiBoardVO;
import kr.icia.service.NotiBoService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NotiBoController {
	private NotiBoService notiservice;

	// 공지사항 목록
	@GetMapping("/list")
	public void list(Model model, Integer startNum) {
		log.info("notice list");
		if (startNum == null) {
			startNum = 1;
		}
		int totalCnt = notiservice.totalCnt();
		int num = totalCnt + 1;
		model.addAttribute("list", notiservice.getList(startNum));
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("num", num);
	}

	// 공지사항 목록 더보기
	@RequestMapping(value="/notice/list", method=RequestMethod.POST)
	@ResponseBody
	public List<NotiBoardVO> moreList(Integer startNum) {
		log.info("notice more list");
		log.info("startNum: " + startNum);
		if (startNum == null) {
			startNum = 1;
		}
		List<NotiBoardVO> result = notiservice.getList(startNum);
		log.info("result: " + result);
		return result;
	}


	// 공지사항 작성폼
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		
	}


	// 공지사항 작성
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(NotiBoardVO noti, RedirectAttributes rttr) {
		log.info("register notice: " + noti);
		notiservice.register(noti);
		rttr.addFlashAttribute("result", noti.getBno());

		return "redirect:/notice/list";
	}


	// 공지사항 조회
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("read notice");
		model.addAttribute("notice", notiservice.getAndRCnt(bno));
	}


	// 공지사항 수정폼
	@GetMapping("/modify")
	public void getModify(@RequestParam("bno") Long bno, Model model) {
		log.info("get modify notice");
		model.addAttribute("notice", notiservice.get(bno));
	}


	// 공지사항 수정
	@PostMapping("/modify")
	public String modify(NotiBoardVO noti, RedirectAttributes rttr) {
		log.info("modify: " + noti);
		if (notiservice.modify(noti)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/notice/list";
	}


	// 공지사항 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		log.info("remove bno: " + bno);
		if (notiservice.remove(bno)) {
			rttr.addFlashAttribute("result", "deleted");
		}
		return "redirect:/notice/list";
	}

}
