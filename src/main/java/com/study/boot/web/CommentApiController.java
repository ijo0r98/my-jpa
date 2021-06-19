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
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/comment")
public class CommentApiController {

    private final MemberService memberService;
    private final BoardService boardService;
    private final CommentService commentService;

    @GetMapping("list/{boardNo}")
    public ResponseEntity<?> commentList(@PathVariable(name = "boardNo") Long boardNo) {

        List<CommentDto> commentDtoList = commentService.findCommentAllByBoardNo(boardNo);

        ApiResponse apiResponse = new ApiResponse(true, "게시물별 댓글 조회");
        apiResponse.putData("commentList", commentDtoList);
        apiResponse.putData("commentCnt", commentDtoList.size());
        return ResponseEntity.ok(apiResponse);
    }

    @PostMapping("register")
    public ResponseEntity<?> registerComment(@Valid @RequestBody CommentRequest commentRequest, Authentication authentication){

        Member member = memberService.loadUserByUsername(authentication.getPrincipal().toString());
        Board board = boardService.findBoardByNo(commentRequest.getBoardNo());
        commentService.registerComment(commentRequest, member, board);

        ApiResponse apiResponse = new ApiResponse(true, "댓글 등록");
        return ResponseEntity.ok(apiResponse);
    }
}
