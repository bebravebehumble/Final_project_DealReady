package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.icia.domain.UserStoreAttachVO;
import kr.icia.domain.UserStoreBoardVO;
import kr.icia.mapper.UserStoreBoMapper;
import kr.icia.mapper.UstoreBoAttachMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserStoreBoServiceImp implements UserStoreBoService {
	@Setter(onMethod_ = @Autowired)
	private UserStoreBoMapper userstorebomapper;

	@Setter(onMethod_ = @Autowired)
	private UstoreBoAttachMapper ustoreattmapper;

	// 상품 업로드
	@Transactional
	@Override
	public void register(UserStoreBoardVO store) {
		log.info("upload goods......");
		userstorebomapper.uploadPd(store);

		if(store.getImgList() == null || store.getImgList().size() <= 0) {
			return;
		}
		store.getImgList().forEach(image -> {
			image.setPdId(store.getPdId());
			ustoreattmapper.uploadImg(image);
		});
	}

	// 상품 수정폼
	@Override
	public UserStoreBoardVO get(Long pno) {
		log.info("modify goods info......");
		return userstorebomapper.read(pno);
	}

	// 상품 상세페이지
	@Transactional
	@Override
	public UserStoreBoardVO getAndCnt(Long pno) {
		log.info("get goods info......");
		userstorebomapper.updateReadCnt(pno);
		return userstorebomapper.read(pno);
	}

	// 상품 수정
	@Transactional
	@Override
	public boolean modify(UserStoreBoardVO store) {
		log.info("modify goods......" + store);
		ustoreattmapper.deleteAll(store.getPdId());
		boolean modifyResult = false;
		modifyResult = userstorebomapper.update(store) == 1;
		int imgList = 0;

		if (store.getImgList() != null) {
			imgList = store.getImgList().size();
		}
		if (modifyResult && imgList > 0) {
			store.getImgList().forEach(image -> {
				image.setPdId(store.getPdId());
				ustoreattmapper.uploadImg(image);
			});
		}
		return modifyResult;
	}

	// 상품 삭제
	@Transactional
	@Override
	public boolean remove(String pdId) {
		log.info("remove goods......" + pdId);
		ustoreattmapper.deleteAll(pdId);
		return userstorebomapper.delete(pdId) == 1;
	}

	// 상품 목록
	@Override
	public List<UserStoreBoardVO> getList(String writer) {
		log.info("store goods list......");
		return userstorebomapper.getList(writer);
	}

	// 이미지 파일 정보 로딩
	@Override
	public List<UserStoreAttachVO> getImgList(String pdId) {
		log.info("getImgList by: " + pdId);
		return ustoreattmapper.imgList(pdId);
	}


	// 작성자별 상품 개수
	@Override
	public int totalCnt(String writer) {
		return userstorebomapper.totalCnt(writer);
	}
}
