package com.study.boot.member.service;

import com.study.boot.member.domain.Member;
import com.study.boot.member.domain.Role;
import com.study.boot.member.repository.MemberRepository;
import com.study.boot.payload.request.SignupRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class MemberService implements UserDetailsService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public Member loadUserByUsername(String username) throws UsernameNotFoundException {
        return memberRepository.findByMemberId(username)
                .orElseThrow(()->new UsernameNotFoundException("no member - " + username));
    }

    @Transactional
    public void signUpMember(SignupRequest signupRequest) {

        Member member = new Member();
        LocalDateTime now = LocalDateTime.now();

        member.setMemberPw(passwordEncoder.encode(signupRequest.getMemberPw()));

        member.setMemberId(signupRequest.getMemberId());
        member.setMemberNm(signupRequest.getMemberNm());
        member.setMemberEmail(signupRequest.getMemberEmail());
        member.setMemberTell(signupRequest.getMemberTell());
        member.setMemberRole(Role.ROLE_MEMBER);
        member.setRegDate(now);
        member.setUpdateDate(now);

        memberRepository.save(member);
    }

    public Member findById(Long memberNo) {
        return memberRepository.findById(memberNo).orElseThrow(NoSuchFieldError::new);
    }

}
