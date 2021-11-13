package com.study.boot.view;

import com.study.boot.board.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin")
public class AdminController {

    private final CategoryService categoryService;

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
    public ModelAndView category() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("category", categoryService.findCategoryCntAll());
        modelAndView.setViewName("/admin/category");
        return modelAndView;
    }
}
