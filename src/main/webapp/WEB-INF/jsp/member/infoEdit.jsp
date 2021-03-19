<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
<h4>사용자 정보 수정</h4>
<sec:csrfMetaTags />
<table id="tbSignup">
    <tr>
        <td>아이디 :</td>
        <td><a type="text" id="newMemberId"/></td>
    </tr>
    <tr>
        <td>이름 :</td>
        <td><a type="text" id="newMemberNm"/></td>
    </tr>
    <tr>
        <td>비밀번호 :</td>
        <td><a type="password" id="memberPw"/><button type="button">변경</button></td>
    </tr>
    <tr>
        <td>핸드폰번호 :</td>
        <td><input type="text" id="newMemberTell"/></td>
    </tr>
    <tr>
        <td>이메일 :</td>
        <td><input type="text" id="newMemberEmail"/></td>
</table>
    <button type="submit" id="btnMemberInfoEdit"/>">수정</button>
</body>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        $.ajax({
            url: baseUrl + '/api',
            type: 'GET',
            success: function (result) {
                console.log('success');
            }, error: function (error) {
                console.log('error');
            }
        });

    });
</script>
</html>