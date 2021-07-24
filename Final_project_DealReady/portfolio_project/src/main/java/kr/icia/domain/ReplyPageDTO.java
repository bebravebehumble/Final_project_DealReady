package kr.icia.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	private int replyCnt;	// 댓글 총 개수
	private List<QnaReplyVO> list;	// 댓글 목록

}
