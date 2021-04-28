package com.study.boot.payload.response;

import com.study.boot.board.domain.Board;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BoardDto {

    private Long boardNo;
    private String boardTitle;
    private String boardContent;
    private Long memberNo;
    private String memberName;
    private String memberId;
    private String regDate;
    private int boardViewCnt;
    private int boardRcmdCnt;

    @Builder
    public BoardDto(Board board) {
        this.boardNo = board.getBoardNo();
        this.boardTitle = board.getBoardTitle();
        this.boardContent = board.getBoardContent();
        this.memberNo = board.getMember().getMemberNo();
        this.memberName = board.getMember().getMemberNm();
        this.memberId = board.getMember().getMemberId();
        this.boardViewCnt = board.getBoardViewCnt();
        this.boardRcmdCnt = board.getBoardRcmdCnt();
        this.regDate = board.getRegDate().toString();
    }
}
