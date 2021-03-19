package com.study.boot.payload.request;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CategoryDto {

    @NotNull
    private Long categoryNo;

    @NotNull
    private String categoryName;
}
