package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaReplyVO;
import kr.icia.domain.ReplyPageDTO;
import kr.icia.mapper.QnaBoMapper;
import kr.icia.mapper.QnaReMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QnaReServiceImp implements QnaReService {
	@Setter(onMethod_ = @Autowired)
	private QnaReMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private QnaBoMapper boMapper;


	// 댓글 등록+게시판 목록 제목 옆에 댓글 개수 업데이트
	@Transactional
	@Override
	public int register(QnaReplyVO vo) {
		log.info("register......" + vo);
		boMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}


	// 댓글 불러오기
	@Override
	public QnaReplyVO get(Long rno) {
		log.info("get......" + rno);
		return mapper.read(rno);
	}


	// 댓글 삭제
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove......" + rno);
		QnaReplyVO vo = mapper.read(rno);
		boMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}


	// 댓글 수정
	@Override
	public int modify(QnaReplyVO reply) {
		log.info("modify......" + reply);
		return mapper.update(reply);
	}


	// 댓글 목록
	@Override
	public List<QnaReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply list " + bno);
		return mapper.getList(cri, bno);
	}


	// 댓글 페이징
	@Override
	public ReplyPageDTO getListPage(Criteria cri, long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno),
				mapper.getList(cri, bno));
	}

}
