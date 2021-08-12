package com.study.boot.board.service;

import com.study.boot.board.domain.Board;
import com.study.boot.board.domain.Category;
import com.study.boot.board.repository.BoardRepository;
import com.study.boot.board.repository.CategoryRepository;
import com.study.boot.member.domain.Member;
import com.study.boot.payload.request.BoardRequest;
import com.study.boot.payload.response.BoardDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;
    private final CategoryRepository categoryRepository;


    @Transactional(readOnly = true)
    public List<Board> findBoardAll() {
        return boardRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Board findBoardByNo(Long boardNo) {
        return  boardRepository.getOne(boardNo);
    }

    @Transactional
    public void registerBoard(BoardRequest boardRequest, Member member, Category category) {

        Board board = new Board();
        LocalDateTime now = LocalDateTime.now();

        board.setBoardTitle(boardRequest.getBoardTitle());
        board.setBoardContent(boardRequest.getBoardContent());
        board.setCategory(category);
        board.setRegDate(now);
        board.setUpdateDate(now);
        board.setMember(member);

        boardRepository.save(board);
    }

    @Transactional
    public void updateBoard(BoardRequest boardRequest, Long boardNo) {
        Board board = boardRepository.getOne(boardNo);
        board.updateBoard(boardRequest.getBoardTitle(), boardRequest.getBoardContent(), categoryRepository.getOne(boardRequest.getCategoryNo()));
    }

    @Transactional
    public void deleteByNo(Long boardNo) {
        boardRepository.deleteById(boardNo);
    }

    @Transactional
    public List<BoardDto> findBoardAllByCategoryNo(long categoryNo) {
        return boardRepository.findBoardAllByCategoryNo(categoryNo);
//        List<Board> boards = boardRepository.findAllByCategory_CategoryNo(categoryNo);
//        return boards.stream().map(b -> new BoardDto(b)).collect(Collectors.toList());
    }

    @Transactional
    public List<BoardDto> findBoardByMemberId(String memberName) {
        return boardRepository.findBoardAllByMemberId(memberName);
    }

    @Transactional
    public List<BoardDto> findBoardByMemberNameAndCategory(String memberName, long categoryNo) {
        return boardRepository.findBoardAllByMemberIdAndCategoryNo(memberName, categoryNo);
    }

    @Transactional
    public List<BoardDto> findBoardByMemberNo(long memberNo) {
        return boardRepository.findBoardAllByMemberNo(memberNo);
    }
}
