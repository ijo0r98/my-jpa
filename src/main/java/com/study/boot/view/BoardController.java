package com.study.boot.view;

import com.study.boot.board.service.BoardService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {

    // 메인페이지 (카테고리 전체)
    @GetMapping("/")
    public String home() {
        return "board/home";
    }

    // 카테고리별 메인
    @GetMapping("category/{categoryNo}")
    public ModelAndView boardListAll(@PathVariable(name = "categoryNo") long categoryNo) throws Exception {
        ModelAndView model = new ModelAndView();
        model.addObject("categoryNo", categoryNo);
        model.setViewName("board/home2");

        return model;
    }

    @GetMapping("post/register")
    public String boardRegisterForm() throws Exception {
        return "/post/register";
    }

    @GetMapping("post/{categoryNo}/{postNo}")
    public ModelAndView ModelAndView(@PathVariable(name = "postNo") long boardNo, @PathVariable(name = "categoryNo") long categoryNo) throws Exception {

        ModelAndView model = new ModelAndView();
        model.addObject("categoryNo", categoryNo);
        model.addObject("boardNo", boardNo);
        model.setViewName("/post/detail");

        return model;
    }

    @GetMapping("post/edit/{postNo}")
    public String boardEditForm(@PathVariable(name = "postNo") String boardNo) throws Exception {
        return "/post/edit";
    }


}