package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.NotiBoardVO;
import kr.icia.mapper.NotiBoMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NotiBoServiceImp implements NotiBoService {
	@Setter(onMethod_ = @Autowired)
	private NotiBoMapper notibomapper;

	// 공지사항 목록
	@Override
	public List<NotiBoardVO> getList(Integer startNum) {
		log.info("notice List......");
		return notibomapper.getList(startNum);
	}

	// 공지사항 작성
	@Override
	public void register(NotiBoardVO noti) {
		log.info("notice register: " + noti);
		notibomapper.insertNoti(noti);
	}

	// 공지사항 조회
	@Override
	public NotiBoardVO getAndRCnt(Long bno) {
		log.info("notice get: " + bno);
		notibomapper.updateReadCnt(bno);
		return notibomapper.read(bno);
	}

	// 공지사항 조회(수정용)
	@Override
	public NotiBoardVO get(Long bno) {
		log.info("modify get: " + bno);
		return notibomapper.read(bno);
	}

	// 공지사항 수정
	@Override
	public boolean modify(NotiBoardVO noti) {
		log.info("modify: " + noti);
		return notibomapper.update(noti) == 1;
	}

	// 공지사항 삭제
	@Override
	public boolean remove(Long bno) {
		log.info("delete notice bno: " + bno);
		return notibomapper.delete(bno) == 1;
	}

	// 공지사항 총 개수
	@Override
	public int totalCnt() {
		return notibomapper.totalCnt();
	}

}
