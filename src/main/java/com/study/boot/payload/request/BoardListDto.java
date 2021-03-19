package com.study.boot.payload.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BoardListDto {

    private Long boardNo;
    private String boardTitle;
    private String boardContent;
    private Long memberNo;
    private Long memberName;
    private Integer boardViewCnt;
    private Integer boardRcmdCnt;
}
