package kr.icia.service;

import java.util.List;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaBoAttachVO;
import kr.icia.domain.QnaBoardVO;

public interface QnaBoService {
	public void register(QnaBoardVO board); // 글 등록

	public QnaBoardVO get(Long bno); // 글 가져오기(글 수정폼)

	public QnaBoardVO getAndCnt(Long bno); // 글 가져오기(글 조회-조회수 기능 포함)

	public boolean modify(QnaBoardVO board); // 수정

	public boolean remove(Long bno);	// 글 삭제

	public List<QnaBoardVO> getList(Criteria cri);	// 글 목록
	
	public int getTotal(Criteria cri);
	// 총 게시물 관련 메소드 원형

	public List<QnaBoAttachVO> getAttachList(Long bno);
	// 첨부파일 포함 게시물 정보
}
