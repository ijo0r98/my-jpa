package com.study.boot.member.repository;

import com.study.boot.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

    // 아이디로 회원 조회
    Optional<Member> findByMemberId(String memberId);

    // 아이디 중복검사
    boolean existsByMemberId(String memberId);
}
