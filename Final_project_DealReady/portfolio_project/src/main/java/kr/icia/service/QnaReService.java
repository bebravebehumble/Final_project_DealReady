package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaReplyVO;
import kr.icia.domain.ReplyPageDTO;

public interface QnaReService {
	public int register(QnaReplyVO vo);	// 댓글 작성

	public QnaReplyVO get(Long rno);	// 댓글 조회

	public int remove(Long rno);	// 댓글 삭제

	public int modify(QnaReplyVO reply);	// 댓글 수정

	public List<QnaReplyVO> getList(	// 댓글 목록
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);

	public ReplyPageDTO getListPage(Criteria cri, long bno);
	// 페이징 처리된 목록

}
