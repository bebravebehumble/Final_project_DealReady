package kr.icia.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {
	private static final long serialVersionUID = 1L;
	// CustomUser class를 사용하기 위해 필요한 코드

	private MemJoinVO memjoin;

	// principal 객체 내용
	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(MemJoinVO vo) {
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList()
				.stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		this.memjoin = vo;
	}

}
