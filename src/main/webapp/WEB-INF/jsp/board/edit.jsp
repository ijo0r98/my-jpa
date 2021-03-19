<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <h4>게시글 수정</h4>
</head>
<sec:authorize access="isAuthenticated()">
    <body>
    <div>
        <table>
            <tr>
                <td>제목 :</td>
                <td id="boardTitle"/>
            </tr>
            <tr>
                <td>카테고리 :</td>
                <td><select id="selectCategory"/></td>
            </tr>
            <tr>
                <td>작성자 :</td>
                <td id="memberNm"/>

            </tr>
            <tr>
                <td>내용 :</td>
                <td id="boardContent"/>
            </tr>
        </table>
    </div><br/>
    <div>
        <button type="button" id="btnBoardEdit">수정</button>
        <button type="button" id="btnCancelEdit">취소</button>
    </div>
    </body>
</sec:authorize>

<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        let boardNo = document.location.href.split(baseUrl + "/board/edit/")[1];

        //게시글 기존 정보
        $.ajax({
            url: baseUrl + '/api/board/info/' + boardNo,
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                // console.log(result)
                $('#boardTitle').append($('<input />', {
                    id: 'newBoardTitle',
                    value: result.data.boardInfo.boardTitle
                }));
                $('#memberNm').text(result.data.boardInfo.member.memberNm);
                $('#boardContent').append($('<textarea />', {
                    id: 'newBoardContent',
                    type: 'text',
                    text: result.data.boardInfo.boardContent
                }));

                addSelectCategory(result.data.boardInfo.category.categoryNo);

            }, error: function (error) {
                console.log('error');
            }
        });

        //수정 버튼
        $('#btnBoardEdit').on({
            click: function () {
                // console.log($('#selectCategory option:selected').val());
                if(confirm('수정하시겠습니까?') == true) {
                    $.ajax({
                        url: baseUrl + '/api/board/edit/' + boardNo,
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            'boardTitle': $('#newBoardTitle').val(),
                            'boardContent': $('#newBoardContent').val(),
                            'categoryNo': $('#selectCategory option:selected').val()
                        }),
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                            location.href = '/board/detail/' + boardNo;
                        }, error: function (error) {
                            console.log('error')
                        }
                    });
                }
            }
        });

        //취소 버튼
        $('#btnCancelEdit').on({
            click: function () {
                history.back();
            }
        })


    });

    function addSelectCategory(categoryNo) {
        //게시글 카테고리 셀렉트박스
        $.ajax({
            url: baseUrl + '/api/category/list',
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                // console.log(result)
                $.each(result.data.categoryList, function(key, obj) {
                    $('#selectCategory').append($('<option />', {
                        value: obj.categoryNo,
                        text: obj.categoryName
                    }));
                });

                //기존의 카테고리로 셀렉트 박스 기본값 설정
                $('#selectCategory').val(categoryNo).prop('selected', true);
            }, error: function (error) {
                console.log('error');
            }
        });
    }
</script>
</html>