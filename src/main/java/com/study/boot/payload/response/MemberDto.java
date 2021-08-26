package com.study.boot.payload.response;

import com.study.boot.member.domain.Member;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberDto {
    private long memberNo;
    private String memberId;
    private String memberName;
    private String regDate;
    private String memberRole;

    @Builder
    public MemberDto(Member member) {
        this.memberNo = member.getMemberNo();
        this.memberId = member.getMemberId();
        this.memberName = member.getMemberNm();
        this.memberRole = member.getMemberRole().toString();
        this.regDate = member.getRegDate().toString();
    }
}
