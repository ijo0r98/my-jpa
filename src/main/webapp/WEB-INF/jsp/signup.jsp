<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>
<body>
<sec:csrfMetaTags />
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="/login">By JURAN</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
<%--                <li class="nav-ite">--%>
<%--                    <a class="nav-link" href="#">Home--%>
<%--                        <span class="sr-only">(current)</span>--%>
<%--                    </a>--%>
<%--                </li>--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link" href="#">Mypage</a>--%>
<%--                </li>--%>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-lg-12 ">
            <h1 class="mt-5"></h1>
            <p class="lead">회원가입</p>
            <ul class="list-unstyled">
                <fieldset>
                    <legend>양식을 모두 입력해 주세요</legend>
                    <div class="form-group">
                        <label for="memberName">이름</label>
                        <input type="text" class="form-control" id="memberName" placeholder="Name">
                    </div>
                    <div class="form-group">
                        <label for="memberId">아이디</label>
                        <input type="text" class="form-control" id="memberId" aria-describedby="idHelp"
                               placeholder="Enter email">
                        <small id="idHelp" class="form-text text-muted">아이디는 변경이 불가합니다.</small>
                    </div>
                    <div class="form-group">
                        <label for="memberEmail">이메일 주소</label>
                        <input type="email" class="form-control" id="memberEmail" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="memberPw">비밀번호</label>
                        <input type="password" class="form-control" id="memberPw" placeholder="Password">
                    </div>
                    <div class="form-group">
                        <label for="memberTell">핸드폰 번호</label>
                        <input type="text" class="form-control" id="memberTell" placeholder="Tell">
                    </div>
                </fieldset>
                <div class="form-group">
                    <button type="button" id="btnSignup" class="btn btn-secondary">가입</button>
                </div>
            </ul>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="<c:url value="../../js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="../../js/common.js"/> "></script>
<script type="text/javascript">
    var csrfParameter = '${_csrf.parameterName}';
    var csrfToken = '${_csrf.token}';

    $(document).ready(function () {
        $('#btnSignup').on({
            click: function () {
                $.ajax({
                    url: baseUrl + '/api/member/signup',
                    type: 'POST',
                    contentType: 'application/json',
                    headers: {
                        "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                    },
                    data: JSON.stringify({
                        memberId: $('#memberId').val(),
                        memberNm: $('#memberName').val(),
                        memberPw: $('#memberPw').val(),
                        memberEmail: $('#memberEmail').val(),
                        memberTell: $('#memberTell').val()
                    }),
                    success: function (result) {
                        console.log('success');
                        location.href = '/login';
                        alert('로그인 후 서비스를 이용할 수 있습니다.');
                    }, error: function(error) {
                        console.log('error');
                    }
                });
            }
        });
    })
</script>
</html>