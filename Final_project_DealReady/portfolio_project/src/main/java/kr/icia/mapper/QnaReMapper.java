package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaReplyVO;

public interface QnaReMapper {
	public int insert(QnaReplyVO vo);	// 댓글 작성

	public QnaReplyVO read(Long rno);	// 댓글 조회

	public int delete(Long rno);	// 댓글 삭제

	public int update(QnaReplyVO reply);	// 댓글 수정

	public List<QnaReplyVO> getList(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	// 페이지 정보와 게시물 번호를 전달받는 댓글 목록

	public int getCountByBno(Long bno);		// 총 댓글 개수

	public void deleteAll(Long bno);
	// 해당 게시물 댓글 전부 삭제
}
