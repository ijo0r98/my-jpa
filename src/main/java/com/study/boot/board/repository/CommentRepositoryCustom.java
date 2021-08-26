package com.study.boot.board.repository;

import com.study.boot.payload.response.CommentDto;
import jdk.nashorn.internal.runtime.options.Option;

import java.util.List;
import java.util.Optional;

public interface CommentRepositoryCustom {

    // 게시물별 댓글 조회
    List<CommentDto> findCommentAllByBoardNo(long boardN);

    // 사용자별 댓글 조회 (카테고리 조건 추가)
    List<CommentDto> findCommentAllByMemberNo(String userId, Long categoryNo);

}
