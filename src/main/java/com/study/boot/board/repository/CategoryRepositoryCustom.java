package com.study.boot.board.repository;

import com.querydsl.core.Tuple;
import com.study.boot.payload.response.CategoryListDto;

import java.util.List;

public interface CategoryRepositoryCustom {

    // 전체 카테고리 리스트, 카테고리별 게시글 수 조회
    List<CategoryListDto> findCategoryAndCntAll();

}
