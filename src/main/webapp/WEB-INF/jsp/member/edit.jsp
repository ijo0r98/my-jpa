<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<sec:authorize access="isAnonymous()">

</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <sec:csrfMetaTags/>

    <jsp:include page="../navigation.jsp" flush="false"/>

    <div class="container">
        <div class="row">

            <jsp:include page="mypage.jsp" flush="false"/>

            <div class="col-lg-9">
                <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel"></div>
                <div class="row">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">MyPage</li>
                        <li class="breadcrumb-item active">정보 수정</li>
                    </ol>

                    <div class="card mt-4">
                        <div class="form-group">
                            <label class="form-label mt-4">비밀번호</label>
                            <div class="input-group mb-3" >
                                <input id="inputPw" type="password" class="form-control" placeholder="Password" autocomplete="off" >
                                <button class="btn btn-primary" type="button" id="btnCheckPw">확인</button>
                                <d id="invalidPw" class="invalid-feedback" style="display:none;">잘못된 비밀번호 입니다.</d>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.card -->

                <div class="row">
                    <div class="card mt-4" style="display: none;" id="editForm">
                        <div class="card-header">
                            정보 수정
                        </div>
                        <div class="card-body">
                            <div class="form-group row">
                                <label for="memberName" class="col-sm-2 col-form-label">이름</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="memberName" disabled="true">
                                </div>
                            </div>
                            <br>
                            <div class="form-group row">
                                <label for="memberId" class="col-sm-2 col-form-label">아이디</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="memberId" disabled="true">
                                </div>
                            </div>
                            <br>
                            <div class="form-group row">
                                <label for="memberEmail" class="col-sm-2 col-form-label">이메일</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="memberEmail">
                                </div>
                            </div>
                            <br>
                            <div class="form-group row">
                                <label for="memberTell" class="col-sm-2 col-form-label">전화번호</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="memberTell">
                                </div>
                            </div>
                            <br>
                            <button type="button" class="btn btn-outline-secondary" id="btnEditInfo">수정</button>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
            <!-- /.col-lg-9 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
</sec:authorize>

</body>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">

    $(document).ready(function () {

        $('#edit').addClass('active');

        // 엔터키로 버튼 클릭
        $('#inputPw').keydown(function (keyNum) {
            if(keyNum.keyCode == 13) {
                // console.log('enter!')
                $('#btnCheckPw').click();
            }
        })

        $('#btnCheckPw').on({
            click: function () {
                $.ajax({
                    url: baseUrl + '/api/member/password/check',
                    type: 'POST',
                    contentType: 'application/json',
                    headers: {
                        "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                    },
                    data: JSON.stringify({
                        'password': $('#inputPw').val()
                    }),
                    success: function (result) {
                        // console.log(result);
                        if (result == true) {
                            showEditForm();

                            // 기존 등록된 사용자 정보
                            $.ajax({
                                url: baseUrl + '/api/member/info/me',
                                type: 'GET',
                                contentType: 'application/json',
                                headers: {
                                    "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                                },
                                success: function (result) {
                                    // console.log(result);
                                    memberNo = result.data.memberInfo.memberNo;
                                    $('#memberName').val(result.data.memberInfo.memberName);
                                    $('#memberId').val(result.data.memberInfo.memberId);
                                    $('#memberTell').val(result.data.memberInfo.memberTell);
                                    $('#memberEmail').val(result.data.memberInfo.memberEmail);
                                }, error: function (error) {
                                    console.log(error);
                                }
                            });
                        }
                    }, error: function (error) {
                        // console.log(error);
                        $('#editForm').hide();
                        $('#invalidPw').show();
                    }
                });
            }
        });

        // 전화번호 하이픈 자동 추가
        $('#memberTell').on({
            keyup: function () {
                $(this).val(autoHyphen($(this).val()));
            }
        });

        // 수정 버튼
        $('#btnEditInfo').off('click').on({
            click: function () {
                if (confirm('정보를 변경하시겠습니까?') == true) {
                    if (checkEmail($('#memberEmail').val()) == false) {
                        alert('이메일 형식이 맞지 않습니다.');
                        $('#memberEmail').focus();
                    } else if (checkPhoneNum($('#memberTell').val()) == false) {
                        alert('전화번호 형식이 맞지 않습니다.');
                        $('#memberTell').focus();
                    } else {
                        $.ajax({
                            url: baseUrl + '/api/member/edit',
                            type: 'PUT',
                            contentType: 'application/json',
                            headers: {
                                "X-CSRF-TOKEN": $("meta[name='_csrf']").attr("content")
                            },
                            data: JSON.stringify({
                                'memberNo': memberNo,
                                'memberId': $('#memberId').val(),
                                'memberEmail': $('#memberEmail').val(),
                                'memberTell': $('#memberTell').val()
                            }),
                            success: function (result) {
                                // console.log(result);
                                location.reload();
                            }, error: function (error) {
                                console.log(error);
                            }
                        });
                    }
                }
            }
        });
    });

    // 사용자 정보 수정 입력 칸
    function showEditForm() {
        $('#editForm').show();
        $("#inputPw").attr("disabled", true);
        $('#invalidPw').hide();
    }

</script>
</html>
