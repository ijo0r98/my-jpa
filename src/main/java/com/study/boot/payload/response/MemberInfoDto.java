package com.study.boot.payload.response;

import com.study.boot.member.domain.Member;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MemberInfoDto {

    private long memberNo;

    private String memberId;

    private String memberName;

    private String memberPw;

    private  String memberTell;

    private String memberEmail;

    private String regDate;

    @Builder
    public MemberInfoDto(Member member) {
        this.memberNo = member.getMemberNo();
        this.memberName = member.getMemberNm();
        this.memberId = member.getMemberId();
        this.memberPw = member.getMemberPw();
        this.memberTell = member.getMemberTell();
        this.memberEmail = member.getMemberEmail();
        this.regDate = member.getRegDate().toString();
    }
}
