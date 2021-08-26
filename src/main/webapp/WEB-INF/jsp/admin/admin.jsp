<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div class="col-lg-3">
    <h1 class="my-4">ADMIN</h1>
    <ul class="list-group" >
        <li class="list-group-item d-flex justify-content-between align-items-center" onClick="location.href='/admin/member'" id="members">
            회원 관리
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center" onClick="location.href='/admin/post'" id="posts">
            게시물 관리
        </li>
        <li class="list-group-item d-flex justify-content-between align-items-center" onClick="location.href='/admin/category'" id="category">
            카테고리 관리
        </li>
    </ul>
</div>