package kr.icia.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.Criteria;
import kr.icia.domain.PageDTO;
import kr.icia.domain.QnaBoAttachVO;
import kr.icia.domain.QnaBoardVO;
import kr.icia.service.QnaBoService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/qnaBoard/*")
@AllArgsConstructor
public class QnaBoController {
	private QnaBoService service;

	// 게시판 목록 처리
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("cnt", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// 게시글 등록폼
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		
	}
	
	// 게시글 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(QnaBoardVO board, RedirectAttributes rttr) {
		log.info("register: " + board);
		service.register(board);
		rttr.addFlashAttribute("result", "upload");


		return "redirect:/qnaBoard/list";
	}
	
	// 게시글 조회
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model
			, @ModelAttribute("cri") Criteria cri) {
		log.info("/get");
		model.addAttribute("board", service.getAndCnt(bno));
	}

	// 게시글 수정 글 불러오기
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno, Model model
			, @ModelAttribute("cri") Criteria cri) {
		log.info("/get");
		model.addAttribute("board", service.get(bno));
	}

	// 게시글 수정
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(QnaBoardVO board, RedirectAttributes rttr
			, @ModelAttribute("cri") Criteria cri) {
		log.info("modify: " + board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/qnaBoard/list" + cri.getListLink();
	}
	
	// 게시글 삭제
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr
			, @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("remove: " + bno);
		List<QnaBoAttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "deleted");
		}

		return "redirect:/qnaBoard/list" + cri.getListLink();
	}

	// 게시글 속 첨부파일 목록 탐색
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<QnaBoAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList: " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}

	// 게시물 삭제 시 첨부파일 전체 삭제
	private void deleteFiles(List<QnaBoAttachVO> attachList) {
		if (attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach file......");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file
				= Paths.get("c:\\upload\\" + attach.getUploadPath()
					+ "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}

}
