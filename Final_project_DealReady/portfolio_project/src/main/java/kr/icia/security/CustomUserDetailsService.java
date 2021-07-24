package kr.icia.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.icia.domain.CustomUser;
import kr.icia.domain.MemJoinVO;
import kr.icia.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	// 로그인 매핑 메소드 호출
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		log.warn("load user by userName: " + username);
		MemJoinVO vo = memberMapper.login(username);

		return vo == null? null : new CustomUser(vo);
	}

}
