package com.study.boot.view;

import com.study.boot.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm() {
        return "signup";
    }


    // 사용자 페이지 메인
    @GetMapping("/member")
    public String memberHome(Authentication authentication, ModelMap modelMap) {

        return "home";
    }

    // 개인정보 수정
    @GetMapping("/member/edit")
    public String memberEditForm() {
        return "member/infoEdit";
    }

}
