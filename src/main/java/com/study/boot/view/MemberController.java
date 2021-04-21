package com.study.boot.view;

import com.study.boot.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    // 메인페이지
    @GetMapping("/")
    public String home() {
        return "home";
    }

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm() {
        return "signup";
    }

    // 마이페이지 메인
    @GetMapping("/member/mypage")
    public String myPage() {
        return "member/mypage";
    }

    // 개인정보 수정
    @GetMapping("/member/edit")
    public String memberEditForm() {
        return "member/infoEdit";
    }

}
