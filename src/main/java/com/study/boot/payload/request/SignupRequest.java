package com.study.boot.payload.request;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SignupRequest {

    @NotNull
    private String memberId;

    @NotNull
    private String memberPw;

    @NotNull
    private String memberNm;

    @NotNull
    private String memberTell;

    @NotNull
    private String memberEmail;

}
