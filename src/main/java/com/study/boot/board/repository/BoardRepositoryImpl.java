package com.study.boot.board.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.board.domain.Board;
import com.study.boot.payload.response.BoardDto;
import lombok.RequiredArgsConstructor;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.stream.Collectors;

import static com.study.boot.board.domain.QBoard.*;
import static com.study.boot.board.domain.QCategory.*;
import static com.study.boot.member.domain.QMember.*;

@RequiredArgsConstructor
public class BoardRepositoryImpl implements BoardRepositoryCustom{

    private final JPAQueryFactory queryFactory;

    @Override
    public List<BoardDto> findBoardAllByCategoryNo(long categoryNo) {
//        List<Board> boards = queryFactory
//                .selectFrom(board)
//                .where(board.category.categoryNo.eq(categoryNo))
//                .fetch();

        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .where(board.category.categoryNo.eq(categoryNo))
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }

    @Override
    public List<BoardDto> findBoardAllByMemberId(String memberId) {
        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .where(board.member.memberId.eq(memberId))
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }

    @Override
    public List<BoardDto> findBoardAllByMemberIdAndCategoryNo(String memberId, long categoryNo) {
        List<Board> boards = queryFactory
                .selectFrom(board)
                .leftJoin(board.category, category).fetchJoin()
                .leftJoin(board.member, member).fetchJoin()
                .where(board.member.memberId.eq(memberId).and(board.category.categoryNo.eq(categoryNo)))
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
}
