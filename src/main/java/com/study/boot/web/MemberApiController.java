package com.study.boot.web;

import com.study.boot.member.domain.Member;
import com.study.boot.member.service.MemberService;
import com.study.boot.payload.exception.BadRequestException;
import com.study.boot.payload.request.MemberUpdateRequest;
import com.study.boot.payload.request.SignupRequest;
import com.study.boot.payload.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.CurrentSecurityContext;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberApiController {

    private final MemberService memberService;

    // 회원가입
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@Valid @RequestBody SignupRequest signupRequest) throws Exception {

        memberService.signUpMember(signupRequest);
        ApiResponse apiResponse = new ApiResponse(true, "회원가입 완료");

        return ResponseEntity.ok(apiResponse);
    }

    // 아이디 중복검사
    @GetMapping("/id/check")
    public ResponseEntity<?> checkIdDuplication(@RequestParam(value = "memberId") String memberId) throws BadRequestException {
        System.out.println(memberId);

        if(memberService.existsByMemberId(memberId) == true) {
            throw new BadRequestException("이미 사용중인 아이디 입니다.");
        } else {
            return ResponseEntity.ok("사용 가능한 아이디 입니다.");
        }
    }

    // 사용자 본인 정보 조회
    @GetMapping("/info/me")
    public ResponseEntity<?> memberDetailInfo(Authentication authentication) {
        ApiResponse apiResponse = new ApiResponse(true, "로그인한 사용자 상세정보 조회");
        apiResponse.putData("memberInfo", memberService.findMemberInfoByName(authentication.getPrincipal().toString()));

        return ResponseEntity.ok(apiResponse);
    }

    // 사용자 정보 조회
    @GetMapping("/info/{memberNo}")
    public ResponseEntity<?> memberDetailInfoByNo(@PathVariable(name = "memberNo") long memberNo) {
        ApiResponse apiResponse = new ApiResponse(true, "사용자 상세정보 조회");
        apiResponse.putData("memberInfo", memberService.findMemberInfoById(memberNo));

        return ResponseEntity.ok(apiResponse);
    }

    // 비밀번호로 사용자 확인
    @PostMapping("/password/check")
    public ResponseEntity<?> checkPassword(Authentication authentication, @RequestBody Map<String, Object> params) {

        if(memberService.checkMemberPassword(params.get("password").toString(), authentication.getPrincipal().toString()) == false){
            throw new BadRequestException("잘못된 비밀번호 입니다.");
        } else {
            return ResponseEntity.ok(true);
        }
    }

    @PostMapping("/edit")
    public ResponseEntity<?> editMemberInfo(@RequestBody MemberUpdateRequest memberUpdateRequest) {
        ApiResponse apiResponse = new ApiResponse(true, "사용자 정보 수정");
        memberService.editMemberInfo(memberUpdateRequest);

        return ResponseEntity.ok(apiResponse);
    }
}
