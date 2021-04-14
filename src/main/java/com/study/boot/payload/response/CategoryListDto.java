package com.study.boot.payload.response;

import com.study.boot.board.domain.Category;
import com.sun.istack.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
public class CategoryListDto {

    private long categoryNo;
    private String categoryName;

    private int boardCnt;

//    @Builder
//    public CategorylistDto(Category category) {
//        this.categoryNo = category.getCategoryNo();
//        this.categoryName = category.getCategoryName();
//    }

    public CategoryListDto(long categoryNo, String categoryName, int boardCnt) {
        this.categoryNo = categoryNo;
        this.categoryName = categoryName;
        this.boardCnt = boardCnt;
    }
}
