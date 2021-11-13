package com.study.boot.board.repository;

import com.study.boot.board.domain.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long>, BoardRepositoryCustom {

    // 사용자가 작성한 게시글 전체 조회
    List<Board> findAllByMember_MemberId(String memberName);

    // 카테고리별 게시글 조회
    List<Board> findAllByCategory_CategoryNo(long categoryNo);
}
