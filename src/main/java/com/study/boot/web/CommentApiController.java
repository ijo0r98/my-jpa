package com.study.boot.web;

import com.study.boot.board.domain.Board;
import com.study.boot.board.domain.Comment;
import com.study.boot.board.service.BoardService;
import com.study.boot.board.service.CommentService;
import com.study.boot.member.domain.Member;
import com.study.boot.member.service.MemberService;
import com.study.boot.payload.request.CommentRequest;
import com.study.boot.payload.response.ApiResponse;
import com.study.boot.payload.response.CommentDto;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;
import java.util.OptionalLong;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/comment")
@Slf4j
public class CommentApiController {

    private final MemberService memberService;
    private final BoardService boardService;
    private final CommentService commentService;
    private Authentication authentication;
    private Long categoryNo;

    @GetMapping("list/board/{boardNo}")
    public ResponseEntity<?> listByBoardNo(@PathVariable(value = "boardNo") Long boardNo) {

        List<CommentDto> commentDtoList = commentService.findCommentAllByBoardNo(boardNo);

        ApiResponse apiResponse = new ApiResponse(true, "게시물별 댓글 조회");
        apiResponse.putData("commentList", commentDtoList);
        apiResponse.putData("commentCnt", commentDtoList.size());
        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("list/me")
    public ResponseEntity<?> listByMemberNo(Authentication authentication,
                                                   @RequestParam(value = "categoryNo", required = false) Long categoryNo) {

        String userId = authentication.getPrincipal().toString();
        ApiResponse apiResponse = new ApiResponse(true, "사용자별 댓글 조회");
        apiResponse.putData("commentList", commentService.findCommentAllByMemberNo(userId, categoryNo));
        return ResponseEntity.ok(apiResponse);
    }

    @PostMapping("register")
    public ResponseEntity<?> register(@Valid @RequestBody CommentRequest commentRequest, Authentication authentication){

        Member member = memberService.loadUserByUsername(authentication.getPrincipal().toString());
        Board board = boardService.findBoardByNo(commentRequest.getBoardNo());
        commentService.registerComment(commentRequest, member, board);

        ApiResponse apiResponse = new ApiResponse(true, "댓글 등록");
        return ResponseEntity.ok(apiResponse);
    }
}
