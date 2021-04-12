package com.study.boot.payload.request;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BoardRequest {

    @NotNull
    private String boardTitle;

    @NotNull
    private String boardContent;

    @NotNull
    private Long categoryNo;

}
