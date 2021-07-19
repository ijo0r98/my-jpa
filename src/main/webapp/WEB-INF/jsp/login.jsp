<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand">By JURAN</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h1 class="mt-5"></h1>
            <p class="lead">아이디와 비밀번호를 입력해 주세요</p>
            <ul class="list-unstyled">
                <form action="/login" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <li>
                    <input type="text" class="form-control" placeholder="ID" style="width: 600px; margin: auto" name="username">
                    <div class="invalid-feedback">Sorry, that username's taken. Try another?</div>
                </li>
                <li>
                    <input type="password" class="form-control" placeholder="PWD" style="width: 600px; margin: auto" name="password">
                </li>
                <li>
                    <c:if test="${not empty errorMsg}">
                        ${errorMsg}
                    </c:if>
                </li>
                <li>
                    <button type="submit" class="btn btn-secondary">로그인</button>
                </li>
                </form>
                <button type="button" onclick="location.href='/signup'" class="btn btn-secondary">회원가입</button>
            </ul>
        </div>
    </div>
</div>
</body>
</html>