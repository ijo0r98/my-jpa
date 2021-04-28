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
                        <input type="text" class="form-control" id="memberId" aria-describedby="idHelp" placeholder="Id">
                        <d id="idAvailable" class="valid-feedback" style="display: none;"></d>
                        <d id="idNotAvailable" class="invalid-feedback" style="display: none;"></d>
<%--                        <br />--%>
                        <button type="button" class="btn btn-outline-secondary btn-sm" id="btnCheckDuplication">중복확인</button>

                    </div>
                    <div class="form-group">
                        <label for="memberEmail">이메일 주소</label>
                        <input type="email" class="form-control" id="memberEmail" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="memberPw">비밀번호</label>
                        <input type="password" class="form-control" id="memberPw" placeholder="Password">
                        <small class="emailHelp" >최소 8자 이상 숫자와 문자, 특수 문자가 포함되어야 합니다.</small>
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

        // 전화번호 입력 시 하이픈 자동 추가
        $('#memberTell').on({
            keyup: function () {
                $(this).val(autoHyphen($(this).val()));
            }
        });

        $('#btnSignup').on({
            click: function () {
                console.log(checkPassword($('#memberPw').val()));
                if ($('#memberName').val() == '') {
                    alert('이름을 입력해 주세요.');
                    $('#memberName').focus();
                } else if (checkBlank($('#memberName').val()) == true) {
                    alert('이름에는 공백이 포함될 수 없습니다.');
                    $('#memberName').focus();
                } else if ($('#memberId').val() == '') {
                    alert('아이디를 입력해 주세요.');
                    $('#memberId').focus();
                } else if (checkBlank($('#memberId').val()) == true) {
                    alert('아이디에는 공백이 포함될 수 없습니다.');
                    $('#memberId').focus();
                } else if ($('#memberEmail').val() == '') {
                    alert('이메일을 입력해 주세요.');
                    $('#memberEmail').focus();
                } else if (checkEmail($('#memberEmail').val()) == false) {
                    alert('이메일 형식이 맞지 않습니다.');
                    $('#memberEmail').focus();
                } else if (checkPassword($('#memberPw').val()) == false) {
                    alert('비밀번호 형식에 맞지 않습니다.\n비밀번호에는 문자와 숫자, 특수문자가 포함되어야 합니다.');
                    $('#memberPw').focus();
                } else if ($('#memberTell').val() == '') {
                    alert('전화번호를 입력해 주세요.');
                    $('#memberTell').focus();
                } else if (checkPhoneNum($('#memberTell').val()) == false) {
                    alert('전화번호 형식이 맞지 않습니다.');
                    $('#memberTell').focus();
                } else {
                    $.ajax({
                        url: baseUrl + '/api/member/id/check',
                        type: 'GET',
                        contentType: 'application/json',
                        headers: {
                            "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                        },
                        data: {
                            memberId: $('#memberId').val()
                        },
                        success: function (result) {
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
                                }, error: function (error) {
                                    console.log('error');
                                }
                            });
                        }, error: function (error) {
                            // console.log(error)
                            $('#idAvailable').hide();
                            $('#idNotAvailable').show().text(error.responseJSON['message']).append($('<br />'));
                            $('#memberId').focus();
                        }
                    });
                }
            }
        });

        $('#btnCheckDuplication').off('click').on({
            click: function () {
                if (checkBlank($('#memberId').val()) == true || $('#memberId').val() == '') {
                    $('#idAvailable').hide();
                    $('#idNotAvailable').show().text('아이디에는 공백이 포함될 수 없습니다').append($('<br />'));
                } else {
                    $.ajax({
                        url: baseUrl + '/api/member/id/check',
                        type: 'GET',
                        contentType: 'application/json',
                        headers: {
                            "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                        },
                        data: {
                            memberId: $('#memberId').val()
                        },
                        success: function (result) {
                            // console.log(result);
                            $('#idNotAvailable').hide();
                            $('#idAvailable').show().text(result).append($('<br />'));
                        }, error: function (error) {
                            console.log(error);
                            $('#idAvailable').hide();
                            $('#idNotAvailable').show().text(error.responseJSON['message']).append($('<br />'));
                        }
                    });
                }
            }
        });
    })
</script>
</html>