package kr.icia.service;

import java.util.List;

import kr.icia.domain.NotiBoardVO;

public interface NotiBoService {
	public List<NotiBoardVO> getList(Integer startNum);		// 공지사항 글 목록

	public void register(NotiBoardVO noti);	// 공지사항 작성

	public NotiBoardVO getAndRCnt(Long bno);	// 조회수 기능 포함 공지사항 조회

	public NotiBoardVO get(Long bno);	// 공지사항 조회(수정용)

	public boolean modify(NotiBoardVO noti);	// 공지사항 수정

	public boolean remove(Long bno);	// 공지사항 삭제

	public int totalCnt();	// 공지사항 총 개수

}
