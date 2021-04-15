package com.study.boot.board.repository;

import com.study.boot.payload.response.BoardDto;

import java.util.List;

public interface BoardRepositoryCustom {

    List<BoardDto> findBoardAllByCategoryNo(long categoryNo);
}
