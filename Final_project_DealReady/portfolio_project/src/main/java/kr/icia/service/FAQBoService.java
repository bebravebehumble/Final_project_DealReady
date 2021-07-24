package kr.icia.service;

import java.util.List;

import kr.icia.domain.FAQBoardVO;

public interface FAQBoService {
	public List<FAQBoardVO> getList();	// FAQ 목록

	public void register(FAQBoardVO faq);	// FAQ 작성

	public FAQBoardVO get(Long bno);	// FAQ 조회

	public boolean modify(FAQBoardVO faq);	// FAQ 수정

	public boolean remove(Long bno);	// FAQ 삭제

	public int totalCnt();	// FAQ 총 개수

}
