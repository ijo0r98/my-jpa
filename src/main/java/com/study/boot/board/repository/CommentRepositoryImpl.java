package com.study.boot.board.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.board.domain.Comment;
import com.study.boot.payload.response.CommentDto;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

import static com.study.boot.board.domain.QBoard.*;
import static com.study.boot.board.domain.QComment.*;
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

        return comments.stream().map(c -> new CommentDto(c)).collect(Collectors.toList());
    }
}
