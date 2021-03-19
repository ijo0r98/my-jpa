package com.study.boot.web;

import com.study.boot.member.service.MemberService;
import com.study.boot.payload.request.SignupRequest;
import com.study.boot.payload.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberApiController {

    private final MemberService memberService;

    // 회원가입
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody SignupRequest signupRequest) throws Exception{

        memberService.signUpMember(signupRequest);
        ApiResponse apiResponse = new ApiResponse(true, "회원가입 완료");

        return ResponseEntity.ok(apiResponse);
    }
}
