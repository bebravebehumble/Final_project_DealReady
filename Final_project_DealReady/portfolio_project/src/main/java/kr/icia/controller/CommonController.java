package kr.icia.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.icia.domain.MemJoinVO;
import kr.icia.service.FindAccService;
import kr.icia.service.MemJoinService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@Setter(onMethod_ = @Autowired)
	private MemJoinService memjoinService;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Setter(onMethod_ = @Autowired)
	private FindAccService findservice;

	@Autowired
	private JavaMailSender mailSender;


	// 로그인
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
		}
		if (logout != null) {
			model.addAttribute("logout", "로그아웃된 상태입니다.");
		}
	}

	// 로그아웃에 관한 처리
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	@ResponseBody
	public void logout(HttpServletRequest request) throws Exception {
		log.info("logout");
		HttpSession session = request.getSession();
		session.invalidate();
	}


	// 회원가입폼
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void joinGet() {
		log.info("join form");
	}

	// 회원가입 처리
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinPost(MemJoinVO memjoin) throws Exception {
		log.info("join");
		memjoin.setUserpw(pwencoder.encode(memjoin.getUserpw()));
		String userid = memjoin.getUserid();
		memjoinService.memberJoin(memjoin, userid);
		log.info("join: " + memjoin);
		
		return "redirect:/customLogin";
	}

	// 아이디 중복 검사
	@RequestMapping(value="/useridCk" , method=RequestMethod.POST)
	@ResponseBody
	public String useridCK(String userid) throws Exception {
		log.info("useridck");

		int result = memjoinService.useridCheck(userid);

		log.info("result: " + result);

		if (result != 0) {
			return "find";
		} else {
			return "avaliable";
		}
	}

	// 아이디/비밀번호 찾기 폼
	@GetMapping("/findAccount")
	public void selectAccount() {
	}

	// 아이디 찾기
	@RequestMapping(value="/findAccount/id" , method=RequestMethod.POST)
	@ResponseBody
	public String selectId(String userMail) throws Exception {
		log.info("find id");
		String result = findservice.searchId(userMail);
		
		if (result != null) {
			return result;
		} else {
			return "not found";
		}
	}

	// 비밀번호 찾기
	@RequestMapping(value="/findAccount/pw", method=RequestMethod.POST)
	@ResponseBody
	public String selectPw(String userid, String userMailPw) throws Exception {
		log.info("find pw");
		int result = findservice.searchPw(userid, userMailPw);

		if (result == 1) {
			return "found";
		} else {
			return "not found";
		}
	}

	// 임시 비밀번호 발급
	@RequestMapping(value="/findAccount/pwMail", method=RequestMethod.POST)
	@ResponseBody
	public String pwMailSend(String userid, String userMailPw) throws Exception {
		log.info("pwMailSend");

		// 임시 비밀번호 생성
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		uuid = uuid.substring(0, 10);
		log.info(uuid);

		// 이메일 보낼 준비
		log.info("send pwMail");
		String setFrom = "qlfneef91@naver.com";
		String toMail = userMailPw;
		String title = "[딜레디] " + userid + " 님, 딜레디 임시 비밀번호입니다.";
		String content = "안녕하세요, 딜레디 회원님." + "<br><br>"
				+ "회원님의 임시 비밀번호는 "
				+ "<b>" + uuid + "</b>" + "입니다." + "<br>"
				+ "회원님의 개인 정보 보호를 위해 로그인 후 꼭 비밀번호를 변경해 주시길 바랍니다." + "<br><br><br>"
				+ "감사합니다.<br>딜레디.";

		// 유저 비밀번호 변경
		MemJoinVO memjoin = new MemJoinVO();
		memjoin.setUserid(userid);
		memjoin.setUserMail(userMailPw);
		memjoin.setUserpw(uuid);
		memjoin.setUserpw(pwencoder.encode(memjoin.getUserpw()));
		int result = findservice.pwMailSend(memjoin);

		// 비밀번호를 변경한 결과가 있다면 메일 전송, 없다면 실패
		if (result == 1) {
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);

				return "success";

			} catch(Exception e) {
				e.printStackTrace();
				return "fail";
			}
		} else {
			return "not found";
		}
	}


	// 마이페이지
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/myPage")
	public void getMyPage() {
		
	}


	// 이미지 불러오기
	@GetMapping("/detail")
	public ResponseEntity<byte[]> getImage(String fileName) {
		log.info("get image......" + fileName);
		File file = new File("c:\\upload\\" + fileName);

		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}


	// 이미지 파일 삭제
	@PostMapping("/deleteUploadFile")
	public ResponseEntity<String> deleteFile(String fileName) {
		log.info("deleteFile......" + fileName);
		File file = null;
		try {
			// 썸네일 파일 삭제
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			// 원본 삭제
			String originFileDate = file.getAbsolutePath().substring(0, 21);
			log.info("originFileDate: " + originFileDate);
			String originFilePath= file.getAbsolutePath()
					.substring(file.getAbsolutePath().lastIndexOf("\\")+3);
			log.info("originFilePath: " + originFilePath);
			String originFileName = (originFileDate+originFilePath);
			file = new File(originFileDate+originFilePath);
			file.delete();
			log.info("originFileName: " + originFileName);
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
	}

}
