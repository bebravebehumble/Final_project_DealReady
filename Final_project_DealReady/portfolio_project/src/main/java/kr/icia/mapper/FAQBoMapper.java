package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.FAQBoardVO;

public interface FAQBoMapper {
	public List<FAQBoardVO> getList();	// FAQ 목록

	public void insertFaq(FAQBoardVO faq);	// FAQ 작성

	public FAQBoardVO read(Long bno);	// FAQ 조회

	public int delete(Long bno);	// FAQ 삭제

	public int update(FAQBoardVO faq);	// FAQ 업데이트

	public int totalCnt();	// FAQ 총 개수

}
