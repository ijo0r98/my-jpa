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
                    <li class="breadcrumb-item active">게시물 관리</li>
                </ol>
            </div>
            <br/>
            <div class="form-group row">
                <label for="categoryList" class="col-sm-2 col-form-label">카테고리</label>
                <select class="form-select" id="categoryList" style="width: 200px;">
                    <option selected="" value="">전체</option>
                </select>
            </div>
            <br/>

            <div>
                <table class="table table-hover">
                    <colgroup>
                        <col style="width:10%"/>
                        <col style="width:30%"/>
                        <col style="width:20%"/>
                        <col style="width:20%"/>
                        <col style="width:10%"/>
                        <col style="width:10%"/>
                    </colgroup>
                    <thead>
                    <tr class="table-primary">
                        <th scope="row">No</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성자</th>
                        <th scope="col">등록날짜</th>
                        <th scope="col">조회수</th>
                        <th scope="col">추천수</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyBoardList">
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
<script type="text/javascript" src="<c:url value="/js/admin.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('#posts').addClass('active');

        addBoardListAdmin($('#selectCategory option:selected').val());

        // 카테고리 셀렉트박스
        $.ajax({
            url: baseUrl + '/api/category/list',
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                $.each(result.data.categoryList, function (key, obj) {
                    $('#categoryList').append($('<option />', {
                        value: obj.categoryNo,
                        text: obj.categoryName,

                    }));
                });
            }, error: function (error) {
                console.log('error');
            }
        });

        $('#categoryList').on({
            change: function () {
                addBoardListAdmin($(this).val());
            }
        });
    });
</script>
</html>
