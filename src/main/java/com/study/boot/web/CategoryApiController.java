package com.study.boot.web;

import com.study.boot.board.service.CategoryService;
import com.study.boot.payload.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/category")
public class CategoryApiController {

    private final CategoryService categoryService;

    @GetMapping("list")
    public ResponseEntity<?> categoryListAll() {

        ApiResponse apiResponse = new ApiResponse(true, "게시판 카테고리 전체 조회");
        apiResponse.putData("categoryList",categoryService.findAllCategory());

        return ResponseEntity.ok(apiResponse);
    }
}
