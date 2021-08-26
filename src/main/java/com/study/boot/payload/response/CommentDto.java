package com.study.boot.payload.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentDto {

    private Long commentNo;
    private String commentContent;
    private String regDate;
    private String memberId;
    private String memberName;
    private Long categoryNo;
    private Long boardNo;
    private String boardTitle;

//    public CommentDto(Comment comment) {
//        this.commentNo = comment.getCommentNo();
//        this.commentContent = comment.getCommentContent();
//        this.regDate = comment.getRegDate().toString();
//        this.memberName = comment.getMember().getMemberNm();
//        this.memberId = comment.getMember().getMemberId();
//    }

//   // builder pattern (effective java)
//    public static class Builder {
//
//       // Required parameters(필수 인자)
//       private final Long commentNo;
//       private final String commentContent;
//       private final String regDate;
//       private final String memeberId;
//
//       // Optional parameters - initialized to default values(선택적 인자는 기본값으로 초기화)
//       private Long categoryNo;
//
//       // 필수인자 builder
//       public Builder(Long commentNo, String commentContent, String regDate, String memeberId) {
//           this.commentNo = commentNo;
//           this.commentContent = commentContent;
//           this.regDate = regDate;
//           this.memeberId = memeberId;
//       }
//
//       public Builder category(Long categoryNo) {
//           this.categoryNo = categoryNo;
//           return this;
//       }
//
//   }
}
