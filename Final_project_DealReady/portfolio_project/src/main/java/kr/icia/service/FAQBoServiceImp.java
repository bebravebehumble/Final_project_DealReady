package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.FAQBoardVO;
import kr.icia.mapper.FAQBoMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FAQBoServiceImp implements FAQBoService {
	@Setter(onMethod_ = @Autowired)
	private FAQBoMapper faqbomapper;

	// FAQ 목록
	@Override
	public List<FAQBoardVO> getList() {
		log.info("faq list......");
		return faqbomapper.getList();
	}


	// FAQ 작성
	@Override
	public void register(FAQBoardVO faq) {
		log.info("FAQ register: " + faq);
		faqbomapper.insertFaq(faq);
	}


	// FAQ 조회
	@Override
	public FAQBoardVO get(Long bno) {
		log.info("FAQ get: " + bno);
		return faqbomapper.read(bno);
	}


	// FAQ 수정
	@Override
	public boolean modify(FAQBoardVO faq) {
		log.info("FAQ modify: " + faq);
		return faqbomapper.update(faq) == 1;
	}


	// FAQ 삭제
	@Override
	public boolean remove(Long bno) {
		log.info("delete FAQ bno: " + bno);
		return faqbomapper.delete(bno) == 1;
	}


	// FAQ 총 개수
	@Override
	public int totalCnt() {
		log.info("FAQ total......");
		return faqbomapper.totalCnt();
	}

}
