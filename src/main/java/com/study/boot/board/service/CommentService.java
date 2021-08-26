package com.study.boot.board.service;

import com.study.boot.board.domain.Board;
import com.study.boot.board.domain.Comment;
import com.study.boot.board.repository.CommentRepository;
import com.study.boot.member.domain.Member;
import com.study.boot.payload.request.CommentRequest;
import com.study.boot.payload.response.CommentDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;

    @Transactional
    public List<CommentDto> findCommentAllByBoardNo(long boardNo) {
        return commentRepository.findCommentAllByBoardNo(boardNo);
    }

    @Transactional
    public void registerComment(CommentRequest commentRequest, Member member, Board board) {

        Comment comment = new Comment();
        LocalDateTime now = LocalDateTime.now();

        comment.setMember(member);
        comment.setBoard(board);
        comment.setCategory(board.getCategory());
        comment.setCommentContent(commentRequest.getCommentContent());
        comment.setRegDate(now);
        comment.setUpdateDate(now);

        commentRepository.save(comment);
    }

    @Transactional
    public List<CommentDto> findCommentAllByMemberNo(String username, Long categoryNo) {
        return commentRepository.findCommentAllByMemberNo(username, categoryNo);
    }
}
