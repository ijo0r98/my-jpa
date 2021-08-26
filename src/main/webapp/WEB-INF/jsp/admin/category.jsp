<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    table th, tr{
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
            <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel"></div>

            <div>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">ADMIN</li>
                    <li class="breadcrumb-item active">카테고리 관리</li>
                </ol>
            </div>
            <br>
            <div>
                <table class="table table-hover">
                    <colgroup>
                        <col style="width:5%" />
                        <col style="width:30%" />
                        <col style="width:20%" />
                        <col style="width:15%" />
                        <col style="width:15%" />
                    </colgroup>
                    <thead>
                    <tr class="table-secondary">
                        <th scope="col">No</th>
                        <th scope="col">카테고리명</th>
                        <th scope="col">글 수 </th>
                        <th scope="col">수정</th>
                        <th scope="col">삭제</th>
                    </tr>
                    </thead>
                    <tbody id="tBodyCategoryList">
                    </tbody>
                </table>

                <div class="form-group">
                    <label for="newCategoryInput" class="form-label mt-4">카테고리 추가</label>
                    <div class="d-flex">
                        <input class="form-control me-sm-2" type="text" id="newCategoryInput" name="categoryName">
                        <button class="btn btn-outline-secondary" type="button" id="btnAddCategory">OK</button>
                    </div>
                    <small id="categoryHelp" class="form-text text-muted">새로 등록할 카테고리 이름을 입력하세요</small>
                </div>
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
<script type="text/javascript" src="<c:url value="/js/category.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('#category').addClass('active');

        addCategoryListAdmin();

        $('#btnAddCategory').off('click').on({
            click: function () {
                if (confirm('새로운 카테고리(' + $('#newCategoryInput').val() + ')를 추가하시겠습니까?') == true) {
                    addCategory($('#newCategoryInput').val());
                }
            }
        });
    });


</script>
</html>
