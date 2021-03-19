package com.study.boot.view;

import com.study.boot.board.service.BoardService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;

    @GetMapping("list")
    public String boardList(ModelMap modelMap) throws Exception {
        return "/board/list";
    }

    @GetMapping("register")
    public String boardRegisterForm() throws Exception {
        return "/board/register";
    }

    @GetMapping("detail/{boardNo}")
    public String boardDetailForm(@PathVariable(name = "boardNo") String boardNo) throws Exception {
        return "/board/detail";
    }

    @GetMapping("edit/{boardNo}")
    public String boardEditForm(@PathVariable(name = "boardNo") String boardNo) throws Exception {
        return "/board/edit";
    }

}