package kr.icia.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.UserStoreAttachVO;
import kr.icia.domain.UserStoreBoardVO;
import kr.icia.service.UserStoreBoService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/store/*")
@AllArgsConstructor
public class UserStoreBoController {
	@Setter(onMethod_ = @Autowired)
	private UserStoreBoService ustoreboservice;


	// 상품(상점) 목록
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void getList(Model model, Principal principal) {
		String writer = principal.getName();
		log.info("store goods list......" + writer);
		int i = 0;
		model.addAttribute("i", i);
		model.addAttribute("total", ustoreboservice.totalCnt(writer));
		model.addAttribute("store", ustoreboservice.getList(writer));
	}


	// 상품 등록폼
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/upload")
	public void UploadForm() {
		
	}


	// 상품 업로드
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/upload")
	public String uploadGoods(UserStoreBoardVO store, RedirectAttributes rttr
			, @RequestParam("writer") String writer) {
		log.info("upload goods......");
		// 상품 번호 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date date = new Date();
		String pdDate = sdf.format(date);
		String s_code = "s" + pdDate;
		log.info("s_code: " + s_code);
		store.setPdId(s_code);
		store.setWriter(writer);
		log.info("writer: " + writer);
		String add = store.getUserAdd();
		if (add == null) {
			store.setUserAdd("");
		}
		if (store.getPriceInfo0() == null) {
			store.setPriceInfo0("");
		}
		if (store.getPriceInfo1() == null) {
			store.setPriceInfo1("");
		}
		if (store.getPriceInfo2() == null) {
			store.setPriceInfo2("");
		}
		ustoreboservice.register(store);
		rttr.addFlashAttribute("result", "upload");

		return "redirect:/store/list";
	}


	// 상품 상세 페이지
	@GetMapping("/goods")
	public void get(@RequestParam("pno") Long pno, Model model) {
		log.info("goods page......");
		model.addAttribute("product", ustoreboservice.getAndCnt(pno));
	}


	// 상품 수정폼 내용 로딩
	@GetMapping("/modify")
	public void modifyForm(UserStoreBoardVO store, @RequestParam("pno") Long pno, Model model) {
		log.info("goods modify form......" + store);
		model.addAttribute("store", ustoreboservice.get(pno));
	}


	// 상품 수정
	@PreAuthorize("principal.username == #store.writer")
	@PostMapping("/modify")
	public String modify(UserStoreBoardVO store, @RequestParam("pdId") String pdId
			, RedirectAttributes rttr) {
		store.setPdId(pdId);
		log.info("pdId: " + pdId);
		String add = store.getUserAdd();
		if (add == null) {
			store.setUserAdd("");
		}
		if (store.getPriceInfo0() == null) {
			store.setPriceInfo0("");
		}
		if (store.getPriceInfo1() == null) {
			store.setPriceInfo1("");
		}
		if (store.getPriceInfo2() == null) {
			store.setPriceInfo2("");
		}
		log.info("modify goods: " + store);
		if (ustoreboservice.modify(store)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/store/list";
	}


	// 상품 삭제
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("pdId") String pdId, RedirectAttributes rttr, String writer) {
		log.info("remove goods pdId: " + pdId);
		List<UserStoreAttachVO> imgList = ustoreboservice.getImgList(pdId);
		if (ustoreboservice.remove(pdId)) {
			deleteImgs(imgList);
			rttr.addFlashAttribute("result", "deleted");
		}

		return "redirect:/store/list";
	}


	// 첨부파일 업로드(여러 개를 업로드할 수 있도록 MultipartFile 뒤에 [])
	@PostMapping(value="/fileUploadAjax", produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<UserStoreAttachVO>> userStoreFileUpload(MultipartFile[] uploadFile) {
		log.info("userStoreUploadAction......");

		// 파일이 이미지가 맞는지 체크
		for (MultipartFile multipartFile: uploadFile) {
			File fileCheck = new File(multipartFile.getOriginalFilename());
			String type = null;
			try {
				type = Files.probeContentType(fileCheck.toPath());
				log.info("Mime type: " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (!type.startsWith("image")) {
				List<UserStoreAttachVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
		}

		String uploadFolder = "c:\\upload";
		List<UserStoreAttachVO> list = new ArrayList<>();

		// 날짜별 폴더 경로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);

		File uploadPath = new File(uploadFolder, datePath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		// 향상된 for문을 이용한 여러 파일 정보 출력
		for(MultipartFile multipartFile : uploadFile) {
			UserStoreAttachVO vo = new UserStoreAttachVO();

			// 파일 이름
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			// 파일 이름에 uuid 적용(동일한 이름의 파일을 덮어쓰지 않도록 방지하는 역할)
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			uploadFileName = uuid + "_" + uploadFileName;
			// 원래 파일과 썸네일의 type을 일치시키기 위한 변수 생성
			String type = multipartFile.getContentType();
			log.info("original type: " + type);
			type = type.substring(type.lastIndexOf("/") + 1);log.info("type: " + type);
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				multipartFile.transferTo(saveFile);
				// 썸네일 생성
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				BufferedImage bfo_img = ImageIO.read(saveFile);

				// 썸네일 크기
				int tw = 200, th = 200;

				// 원본 크기
				int ow = bfo_img.getWidth();
				int oh = bfo_img.getHeight();

				// 원본 너비 기준 높이 계산
				int mw = ow;
				int mh = (ow * th) / tw;

				if (mh > oh) {
					mw = (oh * tw) / th;
					mh = oh;
				}

				// crop
				BufferedImage cropImg = Scalr.crop(bfo_img, (ow-mw)/2, (oh-mh)/2, mw, mh);
				BufferedImage thumbImg = Scalr.resize(cropImg, tw, th);

				ImageIO.write(thumbImg, type, thumbnailFile);
				list.add(vo);
			} catch (Exception e) {
				e.printStackTrace();
			}
//			log.info("-------------------------------");
//			log.info("파일 이름: " + multipartFile.getOriginalFilename());
//			log.info("파일 타입: " + multipartFile.getContentType());
//			log.info("파일 크기: " + multipartFile.getSize());
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}


	// 수정 시 기존 이미지 파일 목록 로딩
	@GetMapping(value="/getImgList", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<UserStoreAttachVO>> getImgList(String pdId) {
		log.info("getImgList: " + pdId);
		return new ResponseEntity<>(ustoreboservice.getImgList(pdId), HttpStatus.OK);
	}


	// 게시물 삭제 시 첨부파일 전체 삭제
	private void deleteImgs(List<UserStoreAttachVO> imgList) {
		if (imgList == null || imgList.size() == 0) {
			return;
		}
		log.info("delete all img file......" + imgList);
		imgList.forEach(img -> {
			try {
				Path file
				= Paths.get("c:\\upload\\" + img.getUploadPath() + "\\"
						+ img.getUuid() + "_" + img.getFileName());
				log.info(file);
				Files.deleteIfExists(file);
				Path thumb
				= Paths.get("c:\\upload\\" + img.getUploadPath() + "\\s_"
						+ img.getUuid() + "_" + img.getFileName());
				log.info(thumb);
				Files.deleteIfExists(thumb);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}

}
