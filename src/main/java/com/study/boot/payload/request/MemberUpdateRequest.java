package com.study.boot.payload.request;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Getter
@Setter
@NoArgsConstructor
public class MemberUpdateRequest {

    @NotBlank
    private long memberNo;

    @NotBlank
    private String memberId;

    @Email
    private String memberEmail;

    @NotBlank
    private String memberTell;
}
