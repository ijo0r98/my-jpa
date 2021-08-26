package com.study.boot.board.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.board.domain.Comment;
import com.study.boot.member.domain.Role;
import com.study.boot.payload.response.CommentDto;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.study.boot.board.domain.QBoard.*;
import static com.study.boot.board.domain.QComment.*;
import static com.study.boot.board.domain.QCategory.*;
import static com.study.boot.member.domain.QMember.*;

@RequiredArgsConstructor
public class CommentRepositoryImpl implements CommentRepositoryCustom{

    private final JPAQueryFactory queryFactory;

    @Override
    public List<CommentDto> findCommentAllByBoardNo(long boardNo) {

        List<Comment> comments = queryFactory
                .selectFrom(comment)
                .leftJoin(comment.member, member).fetchJoin()
                .leftJoin(comment.board, board).fetchJoin()
                .where(comment.board.boardNo.eq(boardNo))
                .fetch();

//        return comments.stream().map(c -> new CommentDto(c)).collect(Collectors.toList());

        return comments.stream().map(c -> CommentDto.builder()
                .commentContent(c.getCommentContent())
                .commentNo(c.getCommentNo())
                .memberId(c.getMember().getMemberId())
                .memberName(c.getMember().getMemberNm())
                .regDate(c.getRegDate().toString())
                .build())
                .collect(Collectors.toList());
    }


    @Override
    public List<CommentDto> findCommentAllByMemberNo(String userId, Long categoryNo) {

        List<Comment> comments = queryFactory
                .selectFrom(comment)
                .leftJoin(comment.member, member).fetchJoin()
                .leftJoin(comment.board, board).fetchJoin()
                .leftJoin(comment.category, category).fetchJoin()
                .where(comment.member.memberId.eq(userId), categoryEg(categoryNo))
                .fetch();

        return comments.stream().map(c -> CommentDto.builder()
                .commentContent(c.getCommentContent())
                .commentNo(c.getCommentNo())
                .memberId(c.getMember().getMemberId())
                .memberName(c.getMember().getMemberNm())
                .boardNo(c.getBoard().getBoardNo())
                .boardTitle(c.getBoard().getBoardTitle())
                .regDate(c.getRegDate().toString())
                .categoryNo(c.getBoard().getCategory().getCategoryNo())
                .build())
                .collect(Collectors.toList());
    }

    private BooleanExpression categoryEg(Long categoryNo) {
        return categoryNo != null ? comment.category.categoryNo.eq(categoryNo) : null;
    }
}