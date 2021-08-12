<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!-- Responsive navbar-->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="/">JPA로 만든 게시판</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/about.html">About</a></li>
                <li class="nav-item"><a class="nav-link" href="/contact">Contact</a></li>
                <li>
                    <sec:authorize access="isAnonymous()">
                        <button type="button" class="btn btn-secondary my-2 my-sm-0" onclick="location.href='/login'">LOGIN</button>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication property="principal" var="username"/>
                         <li class="nav-item" ><a href="/member/mypage" class="nav-link">MyPage</a></li>
                        <li class="nav-link active" >&nbsp; ${username}</li>
                        <button type="button" class="btn btn-secondary my-2 my-sm-0" onclick="location.href='/logout'">LOGOUT</button>
                    </sec:authorize>
                </li>
            </ul>
        </div>
    </div>
</nav>