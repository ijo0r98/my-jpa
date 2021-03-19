<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <h4>게시글 상세보기</h4>
</head>
<sec:authorize access="isAuthenticated()">
    <body>
    <table>
        <tr>
            <td>제목 :</td>
            <td id="boardTitle"></td>
        </tr>
        <tr>
            <td>카테고리 :</td>
            <td id="categoryNm"></td>
        </tr>
        <tr>
            <td>작성자 :</td>
            <td id="memberNm"></td>

        </tr>
        <tr>
            <td>내용 :</td>
            <td id="boardContent"></td>
        </tr>
        <tr>
            <td>조회수 :</td>
            <td id="boardViewCnt"></td>
        </tr>
        <tr>
            <td>추천수 :</td>
            <td id="boardRcmdCnt"> </td>
            <td><button type="button">추천</button></td>
        </tr>
    </table>
    <div>
        <button type="button" id="btnBoardEdit">수정</button>
        <button type="button" id="btnBoardDelete">삭제</button>
    </div>
    <a href="/board/list">목록보기</a>
    </body>
</sec:authorize>

<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        let boardNo = document.location.href.split(baseUrl + "/board/detail/")[1];

        //게시글 상세 정보
        $.ajax({
            url: baseUrl + '/api/board/info/' + boardNo,
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                console.log(result)
                $('#boardTitle').text(result.data.boardInfo.boardTitle);
                $('#categoryNm').text(result.data.boardInfo.category.categoryName);
                $('#memberNm').text(result.data.boardInfo.member.memberNm);
                $('#boardContent').text(result.data.boardInfo.boardContent);
                $('#boardViewCnt').text(result.data.boardInfo.boardViewCnt);
                $('#boardRcmdCnt').text(result.data.boardInfo.boardRcmdCnt);

            }, error: function (error) {
                console.log('error');
            }
        });

        //수정 버튼
        $('#btnBoardEdit').on('click', function () {
            location.href = '/board/edit/' + boardNo;
        });

        //삭제 버튼
        $('#btnBoardDelete').on({
            click: function () {
                if(confirm('삭제하시겠습니까?') == true) {
                    $.ajax({
                        url: baseUrl + '/api/board/delete/' + boardNo,
                        type: 'GET',
                        success: function (result) {
                            location.href = '/board/list';
                        }, error: function (error) {
                            console.log('error');
                        }
                    })
                }
            }
        })
    });
</script>
</html>