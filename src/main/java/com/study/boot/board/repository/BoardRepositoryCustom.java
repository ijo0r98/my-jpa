package com.study.boot.board.repository;

import com.study.boot.payload.response.BoardDto;

import java.util.List;

public interface BoardRepositoryCustom {

    // 카테고리별 게시글 전체 조회
    List<BoardDto> findBoardAllByCategoryNo(long categoryNo);

    // 사용자가 작성한 게시글 전체 조회
    List<BoardDto> findBoardAllByMemberId(String memberId);

    // 사용자가 작성한 게시글 카테고리별 조회
    List<BoardDto> findBoardAllByMemberIdAndCategoryNo(String memberId, long categoryNo);

    // 사용자별 게시물 전체 조회
    List<BoardDto> findBoardAllByMemberNo(long memberNo);

}
