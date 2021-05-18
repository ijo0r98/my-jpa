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
<style>
    table th{
        text-align: center;
    }
</style>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <sec:csrfMetaTags />
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
        <div class="col-lg-3">
            <h1 class="my-4">ADMIN</h1>
            <div class="list-group">
                <ul class="list-group">
                    <li class="list-group-item list-group-item-action active" onClick="location.href='/admin'">
                        회원 관리
                    </li>
                    <li class="list-group-item list-group-item-action">
                        게시물 관리
                    </li>
                    <li class="list-group-item list-group-item-action" onClick="location.href='/admin/category'">
                        카테고리 관리
                    </li>
                    <li class="list-group-item list-group-item-action" onClick="location.href='">
                        댓글 관리
                    </li>
                </ul>
            </div>
        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">
            <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel"></div>

            <div class="row">
                <sec:authorize access="isAnonymous()">
                    로그인 후 이용 가능합니다.
                </sec:authorize>

                <sec:authorize access="hasRole('ROLE_MEMBER')">
                    관리자 페이지 입니다.
                </sec:authorize>

                <sec:authorize access="hasRole('ROLE_ADMIN')">
                <div class="form-group">
                    <select class="custom-select" id="roleSelect" style="width: 150px;">
                        <option selected="" value="">전체</option>
                        <option value="member">회원</option>
                        <option value="admin">관리자</option>
                    </select>
                </div>

                <table class="table">
                    <colgroup>
                        <col style="width:5%" />
                        <col style="width:20%" />
                        <col style="width:20%" />
                        <col style="width:20%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">아이디</th>
                        <th scope="col">이름</th>
                        <th scope="col">등록 날짜</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyMemberList">
                    </tbody>
                </table>

            </div>
            </sec:authorize>
            <!-- /.row -->
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
    $(document).ready(function () {

        addMemberList($('#roleSelect option:selected').val());

        $('#roleSelect').on({
            change: function () {
                addMemberList($(this).val());
            }
        });
    });

    function addMemberList(role) {
        $('#tBodyMemberList').empty();
        $.ajax({
            url: baseUrl + '/api/member/list',
            type: 'GET',
            contentType: 'application/json',
            data: {
                role: role
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (result) {
                $('#tBodyAdmin').empty();
                $.each(result.data.memberList, function (key, obj) {
                    $('#tBodyMemberList').append($('<tr />', {
                        mouseover: function () {
                            $(this).css("background-color", "#f4f4f4");
                        },
                        mouseout: function () {
                            $(this).css("background-color", "#ffffff");
                        },
                        click: function () {
                            location.href = '/admin/member/info/' + obj.memberNo;
                        }
                    }).append($('<td />', {
                        text: key + 1,
                        style: "text-align: center;"
                    })).append($('<td />', {
                        text: obj.memberId
                    })).append($('<td />', {
                        text: obj.memberName
                    })).append($('<td />', {
                        text: dateFormat(obj.regDate)
                    })));

                });
            }, error: function (error) {
                console.log('error')
            }
        });
    }
</script>
</html>
