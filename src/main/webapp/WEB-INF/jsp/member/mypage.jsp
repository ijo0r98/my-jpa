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
            <h1 class="my-4">MY PAGE</h1>
            <div class="list-group">
                <ul class="list-group">
                    <li class="list-group-item list-group-item-action active" id="boardAll" onClick="location.href='/member/mypage'">
                        내 게시물
                    </li>
                    <li class="list-group-item list-group-item-action">
                        댓글 관리
                    </li>
                    <li class="list-group-item list-group-item-action" onClick="location.href='/member/edit'">
                        정보 수정
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

                <sec:authorize access="isAuthenticated()">
                <div class="form-group">
                    <select class="custom-select" id="categoryList" style="width: 150px;">
                        <option selected="" value="all">전체</option>
<%--                        <option value="1">One</option>--%>
<%--                        <option value="2">Two</option>--%>
<%--                        <option value="3">Three</option>--%>
                    </select>
                </div>

                <table class="table">
                    <colgroup>
                        <col style="width:30%" />
                        <col style="width:30%" />
                        <col style="width:10%" />
                        <col style="width:10%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">제목</th>
                        <th scope="col">등록 날짜</th>
                        <th scope="col">조회수</th>
                        <th scope="col">추천수</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyBoardList">
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

        addBoardListMe($('#categoryList option:selected').val());

        // 카테고리 리스트
        $.ajax({
            url: baseUrl + '/api/category/list',
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                // console.log(result);
                $.each(result.data.categoryList, function(key, obj) {
                    $('#categoryList').append($('<option />', {
                        value: obj.categoryNo,
                        text: obj.categoryName
                    }));
                });
            }, error: function (error) {
                console.log('error');
            }
        });

        $('#categoryList').on({
            change: function () {
                // console.log($(this).val());
                addBoardListMe($(this).val());
            }
        });
    });

    function addBoardListMe(value) {
        if(value === 'all') {
            //전체 탭
            $.ajax({
                url: baseUrl + '/api/board/list/me',
                type: 'GET',
                contentType: 'application/json',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function (result) {
                    // console.log('success');
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
                            text: dateFormat(obj.regDate)
                        })).append($('<td />', {
                            text: obj.boardViewCnt
                        })).append($('<td />', {
                            text: obj.boardRcmdCnt
                        })));
                    });
                }, error: function (error) {
                    console.log('error' + error);
                }
            });
        } else {
            $.ajax({
                url: baseUrl + '/api/board/list/me/' + value,
                type: 'GET',
                contentType: 'application/json',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
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
                            text: obj.regDate
                        })).append($('<td />', {
                            text: obj.boardViewCnt
                        })).append($('<td />', {
                            text: obj.boardRcmdCnt
                        })));
                    });
                }, error: function (error) {
                    console.log('error' + error);
                }
            });
        }
    }
</script>
</html>
