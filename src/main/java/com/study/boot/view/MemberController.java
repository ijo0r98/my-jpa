package com.study.boot.view;

import com.study.boot.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    // jsp 테스트
    @GetMapping("/test")
    public String test() {
        return "test";
    }

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm() {
        return "signup";
    }

    // 마이페이지 > 게시물관리(메인)
    @GetMapping("/mypage/posts")
    public String myPosts() {
        return "member/posts";
    }

    // 마이페이지 > 게시물관리(메인)
    @GetMapping("/mypage/comments")
    public String myComments() {
        return "member/comments";
    }

    // 마이페이지 > 개인정보 수정
    @GetMapping("/mypage/edit")
    public String myInfoEdit() {
        return "member/edit";
    }

}
