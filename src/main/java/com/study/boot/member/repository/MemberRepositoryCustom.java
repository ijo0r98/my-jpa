package com.study.boot.member.repository;

import com.study.boot.payload.response.MemberDto;

import java.util.List;

public interface MemberRepositoryCustom {

    // 권한별 사용자 전체 조회
    List<MemberDto> findAllByMemberRole(String memberRole);
}
