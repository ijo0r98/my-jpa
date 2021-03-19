<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
<form action="/login" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    아이디와 비밀번호를 입력하세요.<br/>
    <table id="tbLogin">
        <tr>
            <td>아이디 : </td>
            <td> <input type="text" name="username" /> <br/></td>
        </tr>
        <tr>
            <td>비밀번호 : </td>
            <td><input type="password" name="password"/></td>
        </tr>
    </table>
    <button type="submit">로그인</button>

    <c:if test="${not empty errorMsg}">
        ${errorMsg}
    </c:if>
</form>
<br/>

<button type="button" onclick="location.href='/signup'">회원가입</button>
</body>
</html>