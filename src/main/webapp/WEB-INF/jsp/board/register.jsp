<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <h4>게시글 등록</h4>
</head>
<sec:authorize access="isAuthenticated()">
<body>
    <div>
        <label>제목</label>
        <div>
            <input type="text" name="title" id="boardTitle" />
        </div>
    </div><br/>
    <div>
        <label>카테고리</label>
        <div>
            <select id="selectCategory"></select>
        </div>
    </div><br/>
    <div>
        <label>내용</label>
        <div>
            <textarea name="content" id="boardContent"></textarea>
        </div>
    </div><br/>
    <div>
        <button type="button" id="btnBoarddRegister">등록</button>
        <button type="button" id="btnCancelRegister">취소</button>
    </div>
</body>
</sec:authorize>

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
                console.log(result)
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
                let boardRegConfirm = confirm('등록하시겠습니까?');
                if(boardRegConfirm == true) {
                    $.ajax({
                        url: baseUrl + '/api/board/register',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            'boardTitle': $('#boardTitle').val(),
                            'boardContent': $('#boardContent').val(),
                            'categoryNo': $('#selectCategory option:selected').val()
                        }),
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                            location.href = '/board/list';
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
        })


    });
</script>
</html>