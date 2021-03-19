package com.study.boot.security;

import com.study.boot.member.domain.Member;
import com.study.boot.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomAuthenticationProvider implements AuthenticationProvider {
    //화면에서 입력한 로그인 정보와 DB에서 가져온 사용자의 정보를 비교해주는 인터페이스

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private MemberService memberService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        //Authentication 로그인 정보
        String username = (String) authentication.getPrincipal(); //로그인 이름
        String password = (String) authentication.getCredentials(); //비밀번호

        Member member = memberService.loadUserByUsername(username);

        if (!passwordEncoder.matches(password, member.getPassword())) {
            throw new BadCredentialsException(username);
        }
        if (!member.isEnabled()) {
            throw new DisabledException(username);
        }

        return new UsernamePasswordAuthenticationToken(member.getMemberId(), member.getMemberPw(), member.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return true;
    }
}
