package com.study.boot.board.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.board.domain.Board;
import com.study.boot.payload.response.BoardDto;
import lombok.RequiredArgsConstructor;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.stream.Collectors;

import static com.study.boot.board.domain.QBoard.*;

@RequiredArgsConstructor
public class BoardRepositoryImpl implements BoardRepositoryCustom{

    private final EntityManager em;

    @Override
    public List<BoardDto> findBoardAllByCategoryNo(long categoryNo) {
        JPAQueryFactory queryFactory = new JPAQueryFactory(em);

        List<Board> boards = queryFactory
                .selectFrom(board)
                .where(board.category.categoryNo.eq(categoryNo))
                .fetch();

        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }
}
