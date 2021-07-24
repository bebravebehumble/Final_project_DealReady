package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.UserStoreBoardVO;

public interface UserStoreBoMapper {
	public List<UserStoreBoardVO> getList(String writer); // 상품 목록

	public void uploadPd(UserStoreBoardVO store); // 상품 등록

	public UserStoreBoardVO read(Long pno); // 상품 조회

	public int delete(String pdId); // 삭제

	public int update(UserStoreBoardVO store); // 수정

	public int totalCnt(String writer);
	// 총 상품 리스트 개수를 처리할 메소드 원형 추가

	public int updateReadCnt(Long pno);	// 상품 조회수

}
