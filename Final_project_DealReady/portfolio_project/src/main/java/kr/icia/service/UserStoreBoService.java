package kr.icia.service;

import java.util.List;

import kr.icia.domain.UserStoreAttachVO;
import kr.icia.domain.UserStoreBoardVO;

public interface UserStoreBoService {
	public void register(UserStoreBoardVO store); // 상품 등록

	public UserStoreBoardVO get(Long pno); // 수정용 상품 정보

	public UserStoreBoardVO getAndCnt(Long pno); // 상품 페이지(글 조회-조회수 기능 포함)

	public boolean modify(UserStoreBoardVO store); // 수정

	public boolean remove(String pdId);	// 글 삭제

	public List<UserStoreBoardVO> getList(String writer);	// 글 목록

	public List<UserStoreAttachVO> getImgList(String pdId);
	// 첨부파일 포함 게시물 정보

	public int totalCnt(String writer);
	// 총 게시물 관련 메소드 원형
}
