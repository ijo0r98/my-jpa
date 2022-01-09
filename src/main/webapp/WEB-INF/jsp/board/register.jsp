<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>JPA</title>
    <!-- Favicon-->
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
</head>
<jsp:include page="../navigation.jsp" flush="false"/>

<sec:authorize access="isAnonymous()">
    <jsp:include page="../anonymous.jsp" flush="false"/>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <sec:csrfMetaTags />
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6">
                        <form name="form" method="post" enctype="multipart/form-data" id="frmData">
                          <input class="form-control" type="file" name="image" multiple="multiple"/>
                        </form>
<%--                        <input class="form-control" type="file" id="formFile">--%>
                    <br/>
                        <img class="card-img-top mb-5 mb-md-0" src="https://dummyimage.com/500x500/dee2e6/6c757d.jpg" alt="...">
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="boardTitle" class="form-label mt-4">제목</label>
                            <input type="text" class="form-control" id="boardTitle" placeholder="Title">
                        </div>
                        <div class="form-group">
                            <label for="selectCategory" class="form-label mt-4">카테고리</label>
                            <select class="form-select" id="selectCategory">
                                <option disabled selected>카테고리를 선택해 주세요</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="boardContent" class="form-label mt-4">내용</label>
                            <textarea id="boardContent" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div style="left: 50%; position:absolute">
                <button type="submit" id="btnBoarddRegister" class="btn btn-outline-primary" >등록</button>
                <button type="button" id="btnCancelRegister" class="btn btn-outline-primary">취소</button>
            </div>
            <br/><br/>
        </section>
</sec:authorize>

<jsp:include page="../footer.jsp" flush="false"/>

<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        //게시글 카테고리 셀렉트박스
        $.ajax({
            url: baseUrl + '/api/category/list',
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                $.each(result.data.categoryList, function(key, obj) {
                    $('#selectCategory').append($('<option />', {
                        value: obj.categoryNo,
                        text: obj.categoryName
                    }));
                });
            }, error: function (error) {
                console.log('error');
            }
        });

        //등록 버튼
        $('#btnBoarddRegister').on({
            click: function () {
                let formData = new FormData($("#frmData")[0]);
                formData.append("boardTitle", $('#boardTitle').val());
                formData.append("boardContent", $('#boardContent').val());
                formData.append("categoryNo", $('#selectCategory option:selected').val());

                let boardRegConfirm = confirm('등록하시겠습니까?');
                if(boardRegConfirm == true) {
                    console.log(formData.get("categoryNo"))
                    $.ajax({
                        url: baseUrl + '/api/board/register',
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        contentType: false,
                        processData: false,
                        // data: JSON.stringify({
                        //     'boardTitle': $('#boardTitle').val(),
                        //     'boardContent': $('#boardContent').val(),
                        //     'categoryNo': $('#selectCategory option:selected').val()
                        // }),
                        data: formData,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                            location.href = '/';
                        }, error: function (error) {
                            console.log(error)
                        }
                    });
                }
            }
        });

        //취소 버튼
        $('#btnCancelRegister').on({
            click: function () {
                history.back();
            }
        });


    });
</script>
</html>