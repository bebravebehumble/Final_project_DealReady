package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.NotiBoardVO;

public interface NotiBoMapper {
	public List<NotiBoardVO> getList(Integer startNum);		// 공지사항 목록

	public void insertNoti(NotiBoardVO noti);	// 공지사항 작성

	public NotiBoardVO read(Long bno);		// 공지사항 조회

	public int delete(Long bno);	// 공지사항 삭제

	public int update(NotiBoardVO noti);	// 공지사항 업데이트

	public int updateReadCnt(Long bno);		// 공지사항 조회수

	public int totalCnt();	// 공지사항 총 개수

}
