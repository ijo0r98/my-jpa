<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>By Juran</title>

    <!-- Bootstrap core CSS -->
    <link href="./../../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="./../../css/shop-item.css" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>

<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
    <div class="container">
        <sec:authentication property="principal" var="username"/>
        <a class="navbar-brand" href="/member">${username}님 반갑습니다!</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/member">Home
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Mypage</a>
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

<!-- Page Content -->
<div class="container">

    <div class="row">

        <div class="col-lg-3">
            <h1 class="my-4">게시판</h1>
            <div class="list-group">
                <ul class="list-group" id="categoryList">
                    <li class="list-group-item list-group-item-action active">
                        category1
                        <span class="badge badge-primary badge-pill">14</span>
                    </li>
                    <li class="list-group-item list-group-item-action">
                        category2
                        <span class="badge badge-primary badge-pill">2</span>
                    </li>
                    <li class="list-group-item list-group-item-action">
                        category3
                        <span class="badge badge-primary badge-pill">1</span>
                    </li>
                </ul>
            </div>
        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">

            <div class="card mt-4">
<%--                <img class="card-img-top img-fluid" src="http://placehold.it/900x400" alt="">--%>
                <div class="card-body">
                    <h3 class="card-title" id="boardTitle"></h3>
                    <h4 id="categoryNm" style="font-size: 1.2rem">$24.99</h4>
                    <p class="card-text" id="boardContent"></p>
<%--                    <span class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9734;</span>--%>
                    <p id="boardRegInfo" style="font-size: 0.9rem"></p>
                    <p id="boardViewCnt" style="font-size: 0.9rem"></p>
                    <p id="boardRcmdCnt"></p>
                    <button type="button" class="btn btn-outline-secondary" id="btnBoardEdit">수정</button>
                    <button type="button" class="btn btn-outline-secondary" id="btnBoardDelete">삭제</button>
                </div>

            </div>
            <!-- /.card -->

           <div class="card card-outline-secondary my-4">
                <div class="card-header">
                    댓글
                </div>
                <div class="card-body">
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
                    <small class="text-muted">Posted by Anonymous on 3/1/17</small>
                    <hr>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
                    <small class="text-muted">Posted by Anonymous on 3/1/17</small>
                    <hr>
                    <a href="#" class="btn btn-success">Leave a Review</a>
                </div>
            </div>
            <!-- /.card -->
        </div>
        <!-- /.col-lg-9 -->

    </div>

</div>
<!-- /.container -->

<!-- Footer -->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Your Website 2020</p>
    </div>
    <!-- /.container -->
</footer>

<!-- Bootstrap core JavaScript -->
<script src="../../../vendor/jquery/jquery.min.js"></script>
<script src="./../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {
        let boardNo = document.location.href.split(baseUrl + "/board/detail/")[1];
        //게시글 상세 정보
        $.ajax({
            url: baseUrl + '/api/board/info/' + boardNo,
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                // console.log(result)
                $('#boardTitle').text(result.data.boardInfo.boardTitle);
                $('#categoryNm').text(result.data.boardInfo.category.categoryName);
                $('#boardContent').text(result.data.boardInfo.boardContent);
                $('#boardViewCnt').text('조회수 : ' + result.data.boardInfo.boardViewCnt);
                $('#boardRcmdCnt').text('추천수 : ' + result.data.boardInfo.boardRcmdCnt);
                $('#boardRegInfo').text(result.data.boardInfo.regDate + ' / ' + result.data.boardInfo.member.memberNm);
            }, error: function (error) {
                console.log('error');
            }
        });
        //수정 버튼
        $('#btnBoardEdit').on('click', function () {
            location.href = '/board/edit/' + boardNo;
        });
        //삭제 버튼
        $('#btnBoardDelete').on({
            click: function () {
                if(confirm('삭제하시겠습니까?') == true) {
                    $.ajax({
                        url: baseUrl + '/api/board/delete/' + boardNo,
                        type: 'GET',
                        success: function (result) {
                            location.href = '/member';
                        }, error: function (error) {
                            console.log('error');
                        }
                    })
                }
            }
        })
    });
</script>
</body>

</html>
