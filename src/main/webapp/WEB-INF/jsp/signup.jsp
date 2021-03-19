<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
</head>
<p>회원가입</p>
<body>
<sec:csrfMetaTags />
<table id="tbSignup">
    <tr>
        <td>아이디 :</td>
        <td><input type="text" id="memberId"/></td>
    </tr>
    <tr>
        <td>이름 :</td>
        <td><input type="text" id="memberName"/> <button type="button">중복검사</button><br/></td>
    </tr>
    <tr>
        <td>비밀번호 :</td>
        <td><input type="password" id="memberPw"/></td>
    </tr>
    <tr>
        <td>핸드폰번호 :</td>
        <td><input type="text" id="memberTell"/></td>
    </tr>
    <tr>
        <td>이메일 :</td>
        <td><input type="text" id="memberEmail"/></td>
</table>
    <button type="button" id="btnSignup">확인</button>
</body>
<script type="text/javascript" src="<c:url value="../../js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="../../js/common.js"/> "></script>
<script type="text/javascript">
    var csrfParameter = '${_csrf.parameterName}';
    var csrfToken = '${_csrf.token}';

    $(document).ready(function () {

        $('#btnSignup').on({
            click: function () {
                $.ajax({
                    url: baseUrl + '/api/member/signup',
                    type: 'POST',
                    contentType: 'application/json',
                    headers: {
                        "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                    },
                    data: JSON.stringify({
                        memberId: $('#memberId').val(),
                        memberNm: $('#memberName').val(),
                        memberPw: $('#memberPw').val(),
                        memberEmail: $('#memberEmail').val(),
                        memberTell: $('#memberTell').val()
                    }),
                    success: function (result) {
                        console.log(result);
                        location.href = '/login';
                        alert('로그인 후 서비스를 이용할 수 있습니다.');
                    }, error: function(error) {
                        console.log(error);
                    }
                });
            }
        });
    })
</script>
</html>