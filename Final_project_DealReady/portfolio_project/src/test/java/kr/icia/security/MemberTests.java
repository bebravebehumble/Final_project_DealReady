package kr.icia.security;

import java.util.UUID;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.MemJoinVO;
import kr.icia.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Setter(onMethod_ = @Autowired)
	private DataSource ds;

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;


	// 계정 생성 테스트
//	@Test
//	public void testInsertMember() {
//		String sql = "insert into member_bo(userid, userpw, username) values (?,?,?)";
//
//		for (int i=0; i<100; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//
//			try {
//				con = ds.getConnection();
//				pstmt = con.prepareStatement(sql);
//				pstmt.setString(2, pwencoder.encode("pw" + i));
//
//				if (i < 80) {
//					pstmt.setString(1, "user" + i);
//					pstmt.setString(3, "일반 사용자" + i);
//				} else if (i < 90) {
//					pstmt.setString(1, "manager" + i);
//					pstmt.setString(3, "운영자" + i);
//				} else {
//					pstmt.setString(1, "admin" + i);
//					pstmt.setString(3, "관리자" + i);
//				}
//				pstmt.executeUpdate();
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				if (pstmt != null) {
//					try {
//						pstmt.close();
//					} catch (Exception e) {}
//				}
//				if (con != null) {
//					try {
//						con.close();
//					} catch (Exception e) {}
//				}
//			}
//		}
//	}

	// 계정 권한 부여 테스트
//	@Test
//	public void testInsertAuth() {
//		String sql = "insert into mem_auth_bo (userid, auth) values (?,?)";
//
//		for (int i=0; i<100; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//
//			try {
//				con = ds.getConnection();
//				pstmt = con.prepareStatement(sql);
//
//				if (i < 80) {
//					pstmt.setString(1, "user" + i);
//					pstmt.setString(2, "ROLE_USER");
//				} else if (i < 90) {
//					pstmt.setString(1, "manager" + i);
//					pstmt.setString(2, "ROLE_MEMBER");
//				} else {
//					pstmt.setString(1, "admin" + i);
//					pstmt.setString(2, "ROLE_ADMIN");
//				}
//				pstmt.executeUpdate();
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				if (pstmt != null) {
//					try {
//						pstmt.close();
//					} catch (Exception e) {}
//				}
//				if (con != null) {
//					try {
//						con.close();
//					} catch (Exception e) {}
//				}
//			}
//		}
//	}


	// 로그인 테스트
//	@Test
//	public void memberLoginTest() throws Exception {
//		log.info("result: " + memberMapper.login("admin1"));
//	}


	// 아이디 찾기 테스트
//	@Test
//	public void findIdTest() throws Exception {
//		log.info("id: " + memberMapper.findId("test@naver.com"));
//	}


	// 비밀번호 찾기 테스트
//	@Test
//	public void findPwTest() throws Exception {
//		log.info("pw result: " + memberMapper.findPw("tes333", "test333@naver.com"));
//	}


	// 비밀번호 변경 테스트
	@Test
	public void pwMailSendTest() throws Exception {
		MemJoinVO memjoin = new MemJoinVO();
		memjoin.setUserid("pwchangetest");
		memjoin.setUserMail("qlfneef91@naver.com");

		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		uuid = uuid.substring(0, 10);
		memjoin.setUserpw(uuid);

		log.info("update result: " + memberMapper.pwMailSend(memjoin));
		log.info("result pw: " + memjoin.getUserpw());
	}

}
