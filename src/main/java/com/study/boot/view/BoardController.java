package com.study.boot.view;

import com.study.boot.board.service.BoardService;
import com.study.boot.board.service.CategoryService;
import com.study.boot.board.service.CommentService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.dom4j.rule.Mode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequiredArgsConstructor
public class BoardController {

    private final CategoryService categoryService;
    private final BoardService boardService;
    private final CommentService commentService;

    // 메인페이지 (카테고리 전체)
    @GetMapping("/")
    public String home(ModelMap model) {
        model.addAttribute("boardList", boardService.findBoardAll());
        model.addAttribute("categoryList", categoryService.findCategoryCntAll());
        return "board/home";
    }

    // 카테고리별 메인
    @GetMapping("category/{categoryNo}")
    public ModelAndView boardListAll(@PathVariable(name = "categoryNo") long categoryNo) throws Exception {

        ModelAndView model = new ModelAndView();
        model.addObject("boardList", boardService.findBoardAllByCategoryNo(categoryNo));
        model.addObject("categoryNo", categoryNo);
        model.addObject("categoryList", categoryService.findCategoryCntAll());
        model.setViewName("/board/home");

        return model;
    }

    @GetMapping("post/register")
    public String boardRegisterForm() throws Exception {
        return "/post/register";
    }

    @GetMapping("post/{categoryNo}/{boardNo}")
    public ModelAndView ModelAndView(@PathVariable(name = "boardNo") long boardNo, @PathVariable(name = "categoryNo") long categoryNo) throws Exception {

        ModelAndView model = new ModelAndView();
        model.addObject("categoryNo", categoryNo);
        model.addObject("categoryList", categoryService.findCategoryCntAll());
        model.addObject("boardNo", boardNo);
        model.addObject("board", boardService.findBoardByNo(boardNo));
        model.addObject("comments", commentService.findCommentAllByBoardNo(boardNo));
        model.setViewName("/post/detail");

        return model;
    }

    @GetMapping("post/edit/{boardNo}")
    public ModelAndView boardEditForm(@PathVariable(name = "boardNo") long boardNo) throws Exception {

        ModelAndView model = new ModelAndView();
        model.addObject("boardNo", boardNo);
        model.addObject("categoryList", categoryService.findCategoryCntAll());
        model.addObject("board", boardService.findBoardByNo(boardNo));
        model.setViewName("/post/edit");

        return model;
    }
}