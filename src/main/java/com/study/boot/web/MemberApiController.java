package com.study.boot.web;

import com.study.boot.member.service.MemberService;
import com.study.boot.payload.exception.BadRequestException;
import com.study.boot.payload.request.SignupRequest;
import com.study.boot.payload.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberApiController {

    private final MemberService memberService;

    // 회원가입
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody SignupRequest signupRequest) throws Exception {

        memberService.signUpMember(signupRequest);
        ApiResponse apiResponse = new ApiResponse(true, "회원가입 완료");

        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("/id/check")
    public ResponseEntity<?> checkIdDuplication(@RequestParam(value = "memberId") String memberId) throws BadRequestException {
        System.out.println(memberId);

        if(memberService.existsByMemberId(memberId) == true) {
            throw new BadRequestException("이미 사용중인 아이디 입니다.");
        } else {
            return ResponseEntity.ok("사용 가능한 아이디 입니다.");
        }
    }
}
