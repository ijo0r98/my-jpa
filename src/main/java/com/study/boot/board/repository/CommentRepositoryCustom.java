package com.study.boot.board.repository;

import com.study.boot.payload.response.CommentDto;

import java.util.List;

public interface CommentRepositoryCustom {

    // 게시물별 댓글 조회
    List<CommentDto> findCommentAllByBoardNo(long boardNo);
}
