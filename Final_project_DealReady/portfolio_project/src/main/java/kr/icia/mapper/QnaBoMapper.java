package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaBoardVO;

public interface QnaBoMapper {
	public List<QnaBoardVO> getList(Criteria cri); // 글 목록(페이징 기능 포함)

	public void insertSelectKey(QnaBoardVO board); // 글 등록

	public QnaBoardVO read(Long bno); // 글 조회

	public int delete(Long bno); // 삭제

	public int update(QnaBoardVO board); // 수정

	public int getTotalCount(Criteria cri);
	// 총 게시물 개수를 처리할 메소드 원형 추가

	public void updateReplyCnt
			(@Param("bno") Long bno,
			@Param("amount") int amount);
	// 게시물별 댓글 개수 표시

	public int updateReadCnt(Long bno);	// 조회수
}
