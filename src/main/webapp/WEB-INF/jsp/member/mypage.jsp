<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>




<div class="col-lg-3">
    <h1 class="my-4">MY PAGE</h1>

    <ul class="list-group" >
        <li class="list-group-item d-flex justify-content-between align-items-center" onClick="location.href='/mypage/posts'" id="posts">
            내 게시물
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center" onClick="location.href='/mypage/comments'" id="comments">
            내 댓글
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center" onClick="location.href='/mypage/edit'" id="edit">
            정보 수정
        </li>
    </ul>
</div>
