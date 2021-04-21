<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>By Juran</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>
<body>
<sec:csrfMetaTags />
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <sec:authentication property="principal" var="username"/>
        <a class="navbar-brand" href="/">${username}님 반갑습니다!</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/">Home
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/member/mypage">Mypage</a>
                </li>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Admin</a>
                    </li>
                </sec:authorize>
                <form action="/logout" method="POST">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <sec:authorize access="isAuthenticated()">
                        <button class="btn btn-secondary my-2 my-sm-0" type="submit">LOGOUT</button>
                    </sec:authorize>
                </form>
            </ul>
        </div>
    </div>
</nav>
</nav>


<div class="container">
    <div class="row">
        <div class="col-lg-3">
            <h1 class="my-4">마이페이지</h1>
            <div class="list-group">
                <ul class="list-group" id="categoryList">
                    <li class="list-group-item list-group-item-action" id="boardAll">
                        내 게시물
                    </li>
                    <li class="list-group-item list-group-item-action">
                        댓글 관리
                    </li>
                    <li class="list-group-item list-group-item-action active" onClick="location.href='/member/edit'">
                        정보 수정
                    </li>
                </ul>
            </div>
        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">

            <div class="card mt-4">
                <div class="card-body">
                    <div class="form-group">
                        <label for="inputPw">비밀번호</label>
                        <input type="password" class="form-control" id="inputPw" placeholder="Password">
                        <d id="invalidPw" class="invalid-feedback" style="display: none;">잘못된 비밀번호 입니다.</d>
                    </div>
                    <button type="button" class="btn btn-outline-secondary" id="btnCheckPw">확인</button>
                </div>

            </div>
            <!-- /.card -->

            <div class="card card-outline-secondary my-4" style="display: none;" id="editForm">
                <div class="card-header">
                    정보 수정
                </div>
                <div class="card-body" >
                    <div class="form-group">
                        <label for="memberName">이름</label>
                        <input type="text" class="form-control" id="memberName" disabled="true">
                    </div>
                    <div class="form-group">
                        <label for="memberId">아이디</label>
                        <input type="text" class="form-control" id="memberId" disabled="true">
                    </div>
                    <div class="form-group">
                        <label for="memberEmail">이메일</label>
                        <input type="text" class="form-control" id="memberEmail" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="memberTell">핸드폰 번호</label>
                        <input type="text" class="form-control" id="memberTell" placeholder="Tell">
                    </div>
                </div>
            </div>
            <!-- /.card -->
        </div>
        <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->

</div>
<!-- /.container -->

</body>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    var csrfParameter = '${_csrf.parameterName}';
    var csrfToken = '${_csrf.token}';

    $(document).ready(function () {
        $('#btnCheckPw').on({
            click: function () {
                $.ajax({
                    url: baseUrl + '/api/member/password/check',
                    type: 'POST',
                    contentType: 'application/json',
                    headers: {
                        "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                    },
                    data: JSON.stringify({
                        'password' : $('#inputPw').val()
                    }),
                    success: function (result) {
                        console.log(result)
                        if(result == true) {
                            $('#editForm').show();
                            $("#inputPw").attr("disabled",true).attr("readonly",false);
                            $('#invalidPw').hide();
                        }
                    }, error: function (error) {
                        console.log(error)
                        $('#editForm').hide();
                        $('#invalidPw').show();
                    }
                })
            }
        });


    });
</script>
</html>
