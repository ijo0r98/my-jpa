package com.study.boot.view;

import com.study.boot.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm() {
        return "signup";
    }


    // 사용자 페이지 메인 -게시판리스트
    @GetMapping("/member")
    public String memberHome() {

        return "home";
    }

    // 개인정보 수정
    @GetMapping("/member/edit")
    public String memberEditForm() {
        return "member/infoEdit";
    }

}
