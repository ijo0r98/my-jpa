package com.study.boot.board.repository;

import com.querydsl.core.Tuple;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.study.boot.payload.response.CategoryListDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.criterion.Projection;

import javax.persistence.EntityManager;
import java.util.List;

import static com.study.boot.board.domain.QCategory.*;
import static com.study.boot.board.domain.QBoard.*;

@Slf4j
@RequiredArgsConstructor
public class CategoryRepositoryImpl implements CategoryRepositoryCustom {

//    private final JPAQueryFactory queryFactory;
    private final EntityManager em;

    @Override
    public List<CategoryListDto> findCategoryAndCntAll() {

        JPAQueryFactory jpaQueryFactory = new JPAQueryFactory(em);

        List<CategoryListDto> categoryListDtos = jpaQueryFactory
                .select(Projections.constructor(CategoryListDto.class,
                        category.categoryNo,
                        category.categoryName,
                        category.boards.size()))
                .from(category)
                .fetch();

        return categoryListDtos;
    }
}
