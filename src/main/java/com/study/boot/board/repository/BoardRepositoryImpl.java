package com.study.boot.board.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.board.domain.Board;
import com.study.boot.payload.response.BoardDto;
import lombok.RequiredArgsConstructor;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.stream.Collectors;

import static com.study.boot.board.domain.QBoard.*;
import static com.study.boot.board.domain.QCategory.*;
import static com.study.boot.board.domain.QComment.comment;
import static com.study.boot.member.domain.QMember.*;

@RequiredArgsConstructor
public class BoardRepositoryImpl implements BoardRepositoryCustom{

    private final JPAQueryFactory queryFactory;

    private BooleanExpression categoryEg(Long categoryNo) {
        return categoryNo != null ? board.category.categoryNo.eq(categoryNo) : null;
    }

    @Override
    public List<BoardDto> findBoardAll() {
        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }

    @Override
    public List<BoardDto> findBoardAllByCategoryNo(Long categoryNo) {
        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .where(categoryEg(categoryNo))
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }

    @Override
    public List<BoardDto> findBoardAllByMemberNo(long memberNo) {
        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .where(board.member.memberNo.eq(memberNo))
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }

    @Override
    public List<BoardDto> findBoardAllByMemberIdAndCategoryNo(String memberId, Long categoryNo) {
        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .where(board.member.memberId.eq(memberId), categoryEg(categoryNo))
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }
}
