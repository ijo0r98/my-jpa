package com.study.boot.web;

import com.querydsl.core.Tuple;
import com.study.boot.board.service.BoardService;
import com.study.boot.board.service.CategoryService;
import com.study.boot.payload.response.ApiResponse;
import com.study.boot.payload.response.CategoryListDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.support.HttpRequestHandlerServlet;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/category")
public class CategoryApiController {

    private final CategoryService categoryService;
    private final BoardService boardService;

    @GetMapping("list")
    public ResponseEntity<?> categoryListAll() {

        ApiResponse apiResponse = new ApiResponse(true, "카테고리 리스트 조회");
        apiResponse.putData("categoryList", categoryService.findCategoryCntAll());

        return ResponseEntity.ok(apiResponse);
    }

    @PostMapping("add")
    public ResponseEntity<?> addNewCategory(@RequestBody Map<String, Object> params) {
        ApiResponse apiResponse = new ApiResponse(true, "카테고리 추가");
        categoryService.addCategory(params.get("categoryName").toString());
        System.out.println(params.get("categoryName").toString());

        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("delete/{categoryNo}")
    public ResponseEntity<?> deleteCategoryByNo(@PathVariable(name = "categoryNo") long categoryNo) {
        ApiResponse apiResponse = new ApiResponse(true, "카테고리 삭제");
        categoryService.deleteCategory(categoryNo);

        return ResponseEntity.ok(apiResponse);
    }

}
