package com.study.boot.payload.request;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SignupRequest {

    @NotBlank(message = "아이디를 입력해 주세요.")
    private String memberId;

    @NotBlank(message = "비밀번호를 입력해 주세요.")
    private String memberPw;

    @NotBlank(message = "이름을 입력해 주세요.")
    private String memberNm;

    @NotBlank(message = "전화번호를 입력해 주세요.")
    private String memberTell;

    @NotBlank
    @Email(message = "이메일 형식에 맞지 않습니다.")
    private String memberEmail;

}
