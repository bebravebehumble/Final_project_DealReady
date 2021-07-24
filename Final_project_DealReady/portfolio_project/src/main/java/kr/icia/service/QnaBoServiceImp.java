package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.icia.domain.Criteria;
import kr.icia.domain.QnaBoAttachVO;
import kr.icia.domain.QnaBoardVO;
import kr.icia.mapper.QnaBoAttachMapper;
import kr.icia.mapper.QnaBoMapper;
import kr.icia.mapper.QnaReMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class QnaBoServiceImp implements QnaBoService {
	@Setter(onMethod_ = @Autowired)
	private QnaBoMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private QnaBoAttachMapper attachMapper;

	@Setter(onMethod_ = @Autowired)
	private QnaReMapper replyMapper;


	@Transactional
	@Override
	public void register(QnaBoardVO board) { // 글 작성
		log.info("register......" + board);
		mapper.insertSelectKey(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Transactional
	@Override
	public QnaBoardVO getAndCnt(Long bno) { // 글 조회
		log.info("get......" + bno);
		mapper.updateReadCnt(bno);
		return mapper.read(bno);
	}


	@Override
	public QnaBoardVO get(Long bno) {	// 글 가져오기
		log.info("get......" + bno);
		return mapper.read(bno);
	}


	@Transactional
	@Override
	public boolean modify(QnaBoardVO board) { // 글 수정
		log.info("modify......" + board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = false;
		modifyResult = mapper.update(board) == 1;
		int attachList = 0;

		// 게시물에 첨부파일이 있다면
		if (board.getAttachList() != null) {
			attachList = board.getAttachList().size();
		}
		if (modifyResult && attachList > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) { // 글 삭제
		log.info("remove......" + bno);
		attachMapper.deleteAll(bno);
		replyMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<QnaBoardVO> getList(Criteria cri) { // 글 목록
		log.info("getList......");
		return mapper.getList(cri);
	}

	@Override
	public int getTotal(Criteria cri) {		// 총 게시물 수
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<QnaBoAttachVO> getAttachList(Long bno) {	// 첨부파일 포함 정보 가져오기
		log.info("get Attach list by bno: " + bno);
		return attachMapper.findByBno(bno);
	}
}
