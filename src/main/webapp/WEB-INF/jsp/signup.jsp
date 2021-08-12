<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>
<body>
<sec:csrfMetaTags />

<jsp:include page="navigation.jsp" flush="false"/>
<div class="container py-lg-5">
    <div class="row">
        <div class="container my-5">
            <form>
                <fieldset>
                    <legend>양식을 모두 작성해 주세요</legend>
                    <br/><br/>
                    <br/>
                    <div class="form-group row">
                        <label for="memberName" class="col-sm-2 col-form-label">이름</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="memberName" placeholder="Name" style="width: 770px;">
                        </div>
                    </div>
                    <br>
                    <div class="form-group row">
                        <label for="memberId" class="col-sm-2 col-form-label">아이디</label>
                        <div class="col-sm-10">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" id="memberId" placeholder="Id">
                                <button type="button" class="btn btn-primary" id="btnCheckDuplication">중복 확인</button>
                                <d id="idAvailable" class="valid-feedback" style="display: none;"></d>
                                <d id="idNotAvailable" class="invalid-feedback" style="display: none;"></d>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="form-group row">
                        <label for="memberEmail" class="col-sm-2 col-form-label">이메일 주소</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="memberEmail" placeholder="Email" style="width: 770px;">
                        </div>
                    </div>
                    <br>
                    <div class="form-group row">
                        <label for="memberPw" class="col-sm-2 col-form-label">비밀번호</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="memberPw" placeholder="Password" style="width: 770px;">
                            <small class="emailHelp" >최소 8자 이상 숫자와 문자, 특수 문자가 포함되어야 합니다.</small>
                        </div>
                    </div>
                    <br>
                    <div class="form-group row">
                        <label for="memberTell" class="col-sm-2 col-form-label">핸드폰 번호</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="memberTell" placeholder="Tell" style="width: 770px;">
                        </div>
                    </div>
                    <br>
                    <div class="form-group">
                        <button type="button" id="btnSignup" class="btn btn-secondary my-2 my-sm-0">가입</button>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" flush="false"/>

</body>
<script type="text/javascript" src="<c:url value="../../js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="../../js/common.js"/> "></script>
<script type="text/javascript">
    var csrfParameter = '${_csrf.parameterName}';
    var csrfToken = '${_csrf.token}';

    $(document).ready(function () {

        // 전화번호 입력 시 하이픈 자동 추가
        $('#memberTell').on({
            keyup: function () {
                $(this).val(autoHyphen($(this).val()));
            }
        });

        $('#btnSignup').on({
            click: function () {
                console.log(checkPassword($('#memberPw').val()));
                if ($('#memberName').val() == '') {
                    alert('이름을 입력해 주세요.');
                    $('#memberName').focus();
                } else if (checkBlank($('#memberName').val()) == true) {
                    alert('이름에는 공백이 포함될 수 없습니다.');
                    $('#memberName').focus();
                } else if ($('#memberId').val() == '') {
                    alert('아이디를 입력해 주세요.');
                    $('#memberId').focus();
                } else if (checkBlank($('#memberId').val()) == true) {
                    alert('아이디에는 공백이 포함될 수 없습니다.');
                    $('#memberId').focus();
                } else if ($('#memberEmail').val() == '') {
                    alert('이메일을 입력해 주세요.');
                    $('#memberEmail').focus();
                } else if (checkEmail($('#memberEmail').val()) == false) {
                    alert('이메일 형식이 맞지 않습니다.');
                    $('#memberEmail').focus();
                } else if (checkPassword($('#memberPw').val()) == false) {
                    alert('비밀번호 형식에 맞지 않습니다.\n비밀번호에는 문자와 숫자, 특수문자가 포함되어야 합니다.');
                    $('#memberPw').focus();
                } else if ($('#memberTell').val() == '') {
                    alert('전화번호를 입력해 주세요.');
                    $('#memberTell').focus();
                } else if (checkPhoneNum($('#memberTell').val()) == false) {
                    alert('전화번호 형식이 맞지 않습니다.');
                    $('#memberTell').focus();
                } else {
                    $.ajax({
                        url: baseUrl + '/api/member/id/check',
                        type: 'GET',
                        contentType: 'application/json',
                        headers: {
                            "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                        },
                        data: {
                            memberId: $('#memberId').val()
                        },
                        success: function (result) {
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
                                    console.log('success');
                                    location.href = '/login';
                                    alert('로그인 후 서비스를 이용할 수 있습니다.');
                                }, error: function (error) {
                                    console.log('error');
                                }
                            });
                        }, error: function (error) {
                            // console.log(error)
                            $('#idAvailable').hide();
                            $('#idNotAvailable').show().text(error.responseJSON['message']).append($('<br />'));
                            $('#memberId').focus();
                        }
                    });
                }
            }
        });

        $('#btnCheckDuplication').off('click').on({
            click: function () {
                if (checkBlank($('#memberId').val()) == true || $('#memberId').val() == '') {
                    $('#idAvailable').hide();
                    $('#idNotAvailable').show().text('아이디에는 공백이 포함될 수 없습니다').append($('<br />'));
                } else {
                    $.ajax({
                        url: baseUrl + '/api/member/id/check',
                        type: 'GET',
                        contentType: 'application/json',
                        headers: {
                            "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                        },
                        data: {
                            memberId: $('#memberId').val()
                        },
                        success: function (result) {
                            // console.log(result);
                            $('#idNotAvailable').hide();
                            $('#idAvailable').show().text(result).append($('<br />'));
                        }, error: function (error) {
                            console.log(error);
                            $('#idAvailable').hide();
                            $('#idNotAvailable').show().text(error.responseJSON['message']).append($('<br />'));
                        }
                    });
                }
            }
        });
    })
</script>
</html>