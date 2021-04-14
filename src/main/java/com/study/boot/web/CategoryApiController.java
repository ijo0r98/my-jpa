package com.study.boot.web;

import com.querydsl.core.Tuple;
import com.study.boot.board.service.BoardService;
import com.study.boot.board.service.CategoryService;
import com.study.boot.payload.response.ApiResponse;
import com.study.boot.payload.response.CategoryListDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/category")
public class CategoryApiController {

    private final CategoryService categoryService;
    private final BoardService boardService;

    @GetMapping("list")
    public ResponseEntity<?> categoryListAll() {

        ApiResponse apiResponse = new ApiResponse(true, "카테고리 리스트 조회 완료");
        apiResponse.putData("categoryList", categoryService.findCategoryCntAll());

        return ResponseEntity.ok(apiResponse);
    }
}
