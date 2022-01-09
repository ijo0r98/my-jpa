package com.study.boot.web;

import com.study.boot.board.domain.Category;
import com.study.boot.board.service.BoardService;
import com.study.boot.board.service.CategoryService;
import com.study.boot.board.service.ImageService;
import com.study.boot.member.domain.Member;
import com.study.boot.member.service.MemberService;
import com.study.boot.payload.request.BoardRequest;
import com.study.boot.payload.response.ApiResponse;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Iterator;
import java.util.List;
import java.util.Objects;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/board")
public class BoardApiController {

    private final BoardService boardService;
    private final MemberService memberService;
    private final CategoryService categoryService;
    private final ImageService imageService;

//    @GetMapping("list")
//    public ResponseEntity<?> boardListAll() throws Exception {
//
//        ApiResponse apiResponse = new ApiResponse(true, "게시물 전체 조회");
//        apiResponse.putData("boardList", boardService.findBoardAll());
//
//        return ResponseEntity.ok(apiResponse);
//    }

    @PostMapping(path = "register", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> register(@ModelAttribute BoardRequest boardRequest, Authentication authentication) throws Exception {

//        String[] boardTitle = mtfRequest.getParameterValues("boardTitle"); // FormData 사용시 한글이 깨지는 것을 방지
//        String[] boardContent = mtfRequest.getParameterValues("boardContent");
//        String[] categoryNo = mtfRequest.getParameterValues("categoryNo");
//        String convertToBoardTitle = new String(boardTitle[0].getBytes("8859_1"),"utf-8");
//        String convertToBoardContent = new String(boardContent[0].getBytes("8859_1"),"utf-8");

        System.out.println("boardRequest#######" + boardRequest.getBoardTitle());
        System.out.println("boardRequest#######" + boardRequest.getImage().getOriginalFilename());
        System.out.println("boardRequest#######" + boardRequest.getCategoryNo());


//        Iterator<String> its = mtfRequest.getFileNames();
//        while (its.hasNext()) {
//            String fileNm = (String) its.next();
//            MultipartFile mtf = mtfRequest.getFile(fileNm);
//            imageService.saveImage(mtf);
//        }

        Member member = memberService.loadUserByUsername(authentication.getPrincipal().toString());
        Category category = categoryService.findByCategoryNo(boardRequest.getCategoryNo());
        boardService.registerBoard(boardRequest.getBoardTitle(), boardRequest.getBoardContent(), member, category);
        imageService.saveImage(boardRequest.getImage());
        ApiResponse apiResponse = new ApiResponse(true, "게시물 등록");
        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("info/{boardNo}")
    public ResponseEntity<?> info(@PathVariable(name = "boardNo") Long boardNo) throws Exception{

        ApiResponse apiResponse = new ApiResponse(true, "게시물 상세정보 조회");
        apiResponse.putData("boardInfo", boardService.findBoardByNo(boardNo));
        return ResponseEntity.ok(apiResponse);
    }

    @PostMapping("edit/{boardNo}")
    public ResponseEntity<?> edit(@Validated @PathVariable(name = "boardNo") Long boardNo, @RequestBody BoardRequest boardRequest) throws Exception {

        boardService.updateBoard(boardRequest, boardNo);
        ApiResponse apiResponse = new ApiResponse(true, "게시물 수정");
        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("delete/{boardNo}")
    public ResponseEntity<?> delete(@PathVariable(name = "boardNo") Long boardNo) throws Exception {

        boardService.deleteByNo(boardNo);
        ApiResponse apiResponse = new ApiResponse(true, "게시물 삭제");
        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("list")
    public ResponseEntity<?> listByCategory(@RequestParam(name = "categoryNo", required = false) Long categoryNo) {

        ApiResponse apiResponse = new ApiResponse(true, "카테고리별 게시물 조회");
        apiResponse.putData("boardList", boardService.findBoardAllByCategoryNo(categoryNo));

        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("list/admin/{memberNo}")
    public ResponseEntity<?> listByMemberNo(@PathVariable(name = "memberNo") long memberNo) {

        ApiResponse apiResponse = new ApiResponse(true, "사용자별 게시물 조회");
        apiResponse.putData("boardList", boardService.findBoardByMemberNo(memberNo));

        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("list/me")
    public ResponseEntity<?> listByMemberName(Authentication authentication, @RequestParam(name = "categoryNo", required = false) Long categoryNo) {

        ApiResponse apiResponse = new ApiResponse(true, "로그인한 사용자의 게시물 조회");
        apiResponse.putData("boardList", boardService.findBoardByMemberIdAndCategory(authentication.getPrincipal().toString(), categoryNo));

        return ResponseEntity.ok(apiResponse);
    }
}
