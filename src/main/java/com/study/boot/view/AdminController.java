package com.study.boot.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {

    @GetMapping("member")
    public String member() {
        return "/admin/members";
    }

    @GetMapping("post")
    public String posts() {
        return "/admin/posts";
    }

    @GetMapping("member/info/{memberNo}")
    public String memberInfo() {
        return "/admin/info";
    }

    @GetMapping("category")
    public String editCategory() {
        return "/admin/category";
    }
}
