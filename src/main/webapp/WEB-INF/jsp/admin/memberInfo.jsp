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
                <li class="nav-item">
                    <a class="nav-link" href="/member/mypage">Mypage</a>
                </li>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <li class="nav-item active">
                        <a class="nav-link" href="/admin">Admin</a>
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
        <div class="col-lg-12">
            <div class="card card-outline-secondary my-4">
                <div class="card-header">
                    회원 정보
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <label for="memberId" class="col-sm-2 col-form-label">아이디</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control-plaintext" id="memberId" disabled="true">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="memberName" class="col-sm-2 col-form-label">이름</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control-plaintext" id="memberName"  disabled="true">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="memberEmail" class="col-sm-2 col-form-label">이메일</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control-plaintext" id="memberEmail" disabled="true">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="memberTell" class="col-sm-2 col-form-label">전화번호</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control-plaintext" id="memberTell" disabled="true">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="regDate" class="col-sm-2 col-form-label">가입일자</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control-plaintext" id="regDate" disabled="true">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="memberRoll" class="col-sm-2 col-form-label">권한</label>
                        <div class="col-sm-10">
                            <input type="text" id="memberRoll" disabled="true">
                            <button type="button" class="btn btn-light disabled" id="editRoll">권한 수정</button>
                        </div>
                    </div>
                </div>
                </div>

        <div class="card card-outline-secondary my-4">
            <div class="card-header">
                게시물
            </div>
            <div class="card-body">
                <table class="table">
                    <colgroup>
                        <col style="width:40%" />
                        <col style="width:20%" />
                        <col style="width:20%" />
                        <col style="width:10%" />
                        <col style="width:10%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">제목</th>
                        <th scope="col">카테고리</th>
                        <th scope="col">등록 날짜</th>
                        <th scope="col">조회수</th>
                        <th scope="col">추천수</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyBoardList">
                    </tbody>
                </table>
            </div>
            </div>
            <div class="card card-outline-secondary my-4">
                <div class="card-header">
                    댓글
                </div>
                <div class="card-body">
                    <table class="table">
                        <colgroup>
                            <col style="width:40%" />
                            <col style="width:20%" />
                            <col style="width:20%" />
                            <col style="width:10%" />
                            <col style="width:10%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">제목</th>
                            <th scope="col">카테고리</th>
                            <th scope="col">등록 날짜</th>
                            <th scope="col">조회수</th>
                            <th scope="col">추천수</th>
                        </tr>
                        </thead>
                        <tbody id="tBodyComments">
                        </tbody>
                    </table>
                </div>
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
<script type="text/javascript" src="<c:url value="/js/member.js"/> "></script>
<script type="text/javascript">

    $(document).ready(function () {
        let memberNo = document.location.href.split(baseUrl + "/admin/member/info/")[1];

        $.ajax({
            url: baseUrl + '/api/member/info/' + memberNo,
            type: 'GET',
            contentType: 'application/json',
            headers: {
                "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
            },
            success: function (result) {
                // console.log(result);

                $('#memberName').val(result.data.memberInfo.memberName);
                $('#memberId').val(result.data.memberInfo.memberId);
                $('#memberTell').val(result.data.memberInfo.memberTell);
                $('#memberEmail').val(result.data.memberInfo.memberEmail);
                $('#regDate').val(dateFormat(result.data.memberInfo.regDate));
                $('#memberRoll').val(toMemberRoll(result.data.memberInfo.memberRoll));
                console.log(result.data.memberInfo.memberRoll)
            }, error: function (error) {
                console.log('error');
            }
        });

        $.ajax({
            url: baseUrl + '/api/board/list/admin/' + memberNo,
            type: 'GET',
            contentType: 'application/json',
            headers: {
                "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
            },
            success: function (result) {
                // console.log(result);

                $('#tBodyBoardList').empty();
                $.each(result.data.boardList, function (key, obj) {
                    $('#tBodyBoardList').append($('<tr />', {
                        mouseover: function () {
                            $(this).css("background-color", "#f4f4f4");
                        },
                        mouseout: function () {
                            $(this).css("background-color", "#ffffff");
                        },
                        click: function () {
                            location.href = '/board/detail/' + obj.boardNo;
                        }
                    }).append($('<td />', {
                        text: obj.boardTitle
                    })).append($('<td />', {
                        text: obj.category
                    })).append($('<td />', {
                        text: dateFormat(obj.regDate)
                    })).append($('<td />', {
                        text: obj.boardViewCnt
                    })).append($('<td />', {
                        text: obj.boardRcmdCnt
                    })));
                });
            }, error: function (error) {
                console.log('error');
            }
        });
    });
</script>
</html>
