package com.study.boot.member.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.member.domain.Member;
import com.study.boot.member.domain.Role;
import com.study.boot.payload.response.BoardDto;
import com.study.boot.payload.response.MemberDto;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

//import static org.springframework.util.StringUtils.*;
import static com.study.boot.member.domain.QMember.*;

@RequiredArgsConstructor
public class MemberRepositoryImpl implements MemberRepositoryCustom{

    private final JPAQueryFactory queryFactory;

    @Override
    public List<MemberDto> findAllByMemberRole(String memberRole) {
        List<Member> members = queryFactory
                .select(member)
                .from(member)
                .where(roleNameEq(memberRole))
                .fetch();

        return members.stream().map(m -> new MemberDto(m)).collect(Collectors.toList());
    }

    private BooleanExpression roleNameEq(String role) {
        return role != null ? member.memberRole.eq(Role.valueOf(role)) : null;
    }

}
