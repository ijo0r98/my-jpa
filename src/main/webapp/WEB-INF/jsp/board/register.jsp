<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>
<sec:authorize access="isAuthenticated()">
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
                    <li class="nav-item active">
                        <a class="nav-link" href="/">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
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

    <div class="container">
        <div class="row">
            <div class="col-lg-12 ">
                <h1 class="mt-5"></h1>
                <p class="lead">새 글 등록</p>
                <ul class="list-unstyled">
                    <fieldset>
                        <legend></legend>
                        <div class="form-group">
                            <label for="boardTitle">제목</label>
                            <input type="text" class="form-control" id="boardTitle" placeholder="Title">
                        </div>
                        <div class="form-group">
                            <label for="selectCategory">카테고리</label>
                            <select class="form-control" id="selectCategory">
<%--                                <option>1</option>--%>
<%--                                <option>2</option>--%>
<%--                                <option>3</option>--%>
<%--                                <option>4</option>--%>
<%--                                <option>5</option>--%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="boardContent">내용</label>
                            <textarea class="form-control" id="boardContent" rows="3"></textarea>
                        </div>
                    </fieldset>
                    <div class="form-group">
                        <button type="button" id="btnBoarddRegister" class="btn btn-secondary">등록</button>
                        <button type="button" id="btnCancelRegister" class="btn btn-secondary">취소</button>
                    </div>
                </ul>
            </div>
        </div>
    </div>
</sec:authorize>

<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        //게시글 카테고리 셀렉트박스
        $.ajax({
            url: baseUrl + '/api/category/list',
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                console.log(result)
                $.each(result.data.categoryList, function(key, obj) {
                    $('#selectCategory').append($('<option />', {
                        value: obj.categoryNo,
                        text: obj.categoryName
                    }));
                });
            }, error: function (error) {
                console.log('error');
            }
        });

        //등록 버튼
        $('#btnBoarddRegister').on({
            click: function () {
                let boardRegConfirm = confirm('등록하시겠습니까?');
                if(boardRegConfirm == true) {
                    $.ajax({
                        url: baseUrl + '/api/board/register',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            'boardTitle': $('#boardTitle').val(),
                            'boardContent': $('#boardContent').val(),
                            'categoryNo': $('#selectCategory option:selected').val()
                        }),
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                            location.href = '/';
                        }, error: function (error) {
                            console.log(error)
                        }
                    });
                }
            }
        });

        //취소 버튼
        $('#btnCancelRegister').on({
            click: function () {
                history.back();
            }
        });


    });
</script>
</html>