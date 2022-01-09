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
<style>
    table th, tr {
        text-align: center;
    }
</style>

<jsp:include page="../navigation.jsp" flush="false"/>

<div class="container">
    <div class="row">

        <sec:authorize access="isAnonymous()">
            로그인 후 이용 가능합니다.
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <sec:csrfMetaTags/>

            <!-- admin 카테고리 -->
            <jsp:include page="admin.jsp" flush="false"/>

            <div class="col-lg-9">
                <div class="carousel slide my-4" data-ride="carousel"></div>
                <div>
                    <br/>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">ADMIN</li>
                        <li class="breadcrumb-item active">회원 관리</li>
                    </ol>
                </div>
                <br/>
                <div class="form-group row">
                    <label for="selectRole" class="col-sm-2 col-form-label">권한</label>
                    <select class="form-select" id="selectRole" style="width: 200px;">
                        <option selected="" value="">전체</option>
                        <option value="member">회원</option>
                        <option value="admin">관리자</option>
                    </select>
                </div>
                <br/>

                <div>
                    <table class="table table-hover">
                        <colgroup>
                            <col style="width:5%"/>
                            <col style="width:20%"/>
                            <col style="width:20%"/>
                            <col style="width:20%"/>
                        </colgroup>
                        <thead>
                        <tr class="table-primary">
                            <th scope="row">No</th>
                            <th scope="col">아이디</th>
                            <th scope="col">이름</th>
                            <th scope="col">등록 날짜</th>
                        </tr>
                        </thead>
                        <tbody id="tBodyMemberList">
                        </tbody>
                    </table>
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
<script type="text/javascript">
    $(document).ready(function () {

        $('#members').addClass('active');

        addMemberList($('#selectRole option:selected').val());

        $('#selectRole').on({
            change: function () {
                addMemberList($(this).val());
            }
        });
    });

    function addMemberList(role) {
        $('#tBodyMemberList').empty();

        $.ajax({
            url: baseUrl + '/api/member/list',
            type: 'GET',
            contentType: 'application/json',
            data: {
                role: role
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (result) {
                $('#tBodyAdmin').empty();
                $.each(result.data.memberList, function (key, obj) {
                    $('#tBodyMemberList').append($('<tr />', {
                        class: 'table-light',
                        click: function () {
                            location.href = '/admin/member/info/' + obj.memberNo;
                        }
                    }).append($('<th />', {
                        text: key + 1,
                        scope: 'row',
                    })).append($('<td />', {
                        text: obj.memberId
                    })).append($('<td />', {
                        text: obj.memberName
                    })).append($('<td />', {
                        text: dateFormat(obj.regDate)
                    })));
                });
            }, error: function (error) {
                console.log('error')
            }
        });
    }
</script>
</html>
