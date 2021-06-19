package com.study.boot.payload.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentRequest {

    @NotNull
    private Long boardNo;

    @NotNull
    private String commentContent;

}
