package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.UserStoreBoardVO;
import kr.icia.mapper.MainListBoMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MainListBoServiceImp implements MainListBoService {
	@Setter(onMethod_ = @Autowired)
	public MainListBoMapper mainlistbomapper;

	// 메인 페이지 전체 상품 목록
	@Override
	public List<UserStoreBoardVO> getMainList() {
		log.info("get main list......");
		return mainlistbomapper.getMainList();
	}

}
