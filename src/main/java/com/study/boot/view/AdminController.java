package com.study.boot.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {

    @GetMapping("")
    public String adminHome() {
        return "/admin/admin";
    }

    @GetMapping("member/info/{memberNo}")
    public String memberInfo() {
        return "/admin/memberInfo";
    }

    @GetMapping("category")
    public String editCategory() {
        return "/admin/category";
    }
}
