package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.QnaBoAttachVO;

public interface QnaBoAttachMapper {
	public void insert(QnaBoAttachVO vo);	// 첨부파일 등록

	public void delete(String uuid);	// 첨부파일 등록 취소

	public List<QnaBoAttachVO> findByBno(Long bno);		// 첨부파일 목록

	public void deleteAll(Long bno);	// 첨부파일 전체 삭제

	public List<QnaBoAttachVO> getOldFiles();	// 중복파일명 업로드 가능
}
