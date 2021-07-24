package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.UserStoreAttachVO;

public interface UstoreBoAttachMapper {
	public void uploadImg(UserStoreAttachVO image);	// 이미지 등록

	public void delete(String uuid);	// 이미지 삭제

	public List<UserStoreAttachVO> imgList(String pdId);	// 이미지 목록

	public void deleteAll(String pdId);	// 이미지 전체 삭제(업로드 글 삭제 시)

	public List<UserStoreAttachVO> getOldFiles();	// 중복파일명 업로드 가능

}
