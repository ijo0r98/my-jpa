<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <h4 >사용자 페이지</h4>
</head>
<body>
<%--<button id="test">test</button>--%>
<sec:authorize access="isAnonymous()">
    로그인 후 이용 가능합니다.
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="username"/>
    ${username}님 반갑습니다.
    <li><a href="/member/edit"/>개인정보 수정하기</li>
    <li><a href="/board/list" />게시판</li>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
    <li>사용자 관리</li>
    <li>게시판 관리</li>
</sec:authorize>

<form action="/logout" method="POST">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <button type="submit">LOGOUT</button>
</form>
</body>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

    });
</script>
</html>
