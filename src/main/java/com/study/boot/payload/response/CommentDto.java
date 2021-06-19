package com.study.boot.payload.response;

import com.study.boot.board.domain.Comment;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class CommentDto {

    private Long commentNo;
    private String commentContent;
    private String regDate;
    private String memberName;
    private String memberId;

    @Builder
    public CommentDto(Comment comment) {
        this.commentNo = comment.getCommentNo();
        this.commentContent = comment.getCommentContent();
        this.regDate = comment.getRegDate().toString();
        this.memberName = comment.getMember().getMemberNm();
        this.memberId = comment.getMember().getMemberId();
    }
}
