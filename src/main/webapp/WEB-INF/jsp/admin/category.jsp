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
                    <li class="list-group-item list-group-item-action" onClick="location.href='/admin'">
                        회원 관리
                    </li>
                    <li class="list-group-item list-group-item-action">
                        게시물 관리
                    </li>
                    <li class="list-group-item list-group-item-action active" onClick="location.href='/admin/category'">
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
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">ADMIN</li>
                    <li class="breadcrumb-item active">카테고리 관리</li>
                </ol>

                <table class="table">
                    <colgroup>
                        <col style="width:5%" />
                        <col style="width:30%" />
                        <col style="width:20%" />
                        <col style="width:15%" />
                        <col style="width:15%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">카테고리명</th>
                        <th scope="col">글 수 </th>
                        <th scope="col">수정</th>
                        <th scope="col">삭제</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyCategoryList">
                    </tbody>
                </table>

                <div class="form-group">
                    <label for="newCategoryInput" class="form-label mt-4">카테고리 명</label>
                    <div class="d-flex">
                        <input class="form-control me-sm-2" type="text" id="newCategoryInput" name="categoryName">
                        <button class="btn btn-outline-secondary" type="button" id="btnAddCategory">OK</button>
                    </div>
                    <small id="categoryHelp" class="form-text text-muted">새로 등록할 카테고리 이름을 입력하세요</small>
                </div>
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
<script type="text/javascript" src="<c:url value="/js/category.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        $.ajax({
            url: baseUrl + '/api/category/list',
            type: 'GET',
            contentType: 'application/json',
            success: function (result) {
                // console.log(result);
                $.each(result.data.categoryList, function (key, obj) {
                    $('#tBodyCategoryList').append($('<tr />', {
                    }).append($('<td />', {
                        text: key + 1,
                        style: "text-align: center;"
                    })).append($('<td />', {
                        text: obj.categoryName
                    })).append($('<td />', {
                        text: obj.boardCnt,
                        style: 'text-align: center;'
                    })).append($('<td />').append($('<span />', {
                        class: 'badge bg-light',
                        text: '수정',
                        click: function () {
                            editCategory();
                        }
                    }))));

                    if(obj.boardCnt == 0) {
                        $('#tBodyCategoryList tr').append($('<td />', {
                            text: '삭제',
                            click: function () {
                                if (confirm('해당 카테고리를 삭제하시겠습니까?') == true) {
                                    deleteCategory(obj.categoryNo);
                                }
                            }
                        }))
                    }

                });
            }, error: function (error) {
                console.log(error);
            }
        })

        $('#btnAddCategory').off('click').on({
            click: function () {
                if (confirm('새로운 카테고리(' + $('#newCategoryInput').val() + ')를 추가하시겠습니까?') == true) {
                    addCategory($('#newCategoryInput').val());
                }
            }
        });
    });


</script>
</html>
