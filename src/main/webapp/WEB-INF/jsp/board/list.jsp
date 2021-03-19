<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <h4 >게시글 리스트</h4>
    <meta charset="UTF-8">
    <style>
        th, td {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <table class="table">
        <colgroup>
            <col style="width:30%" />
            <col style="width:10%" />
            <col style="width:15%" />
            <col style="width:10%" />
            <col style="width:10%" />
            <col style="width:auto" />
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">등록 날짜</th>
            <th scope="col">조회수</th>
            <th scope="col">추천수</th>
        </tr>
        </thead>
        <tbody id="tBodyBoardList">
<%--        <tr>--%>
<%--            <td>d</td>--%>
<%--            <td>d</td>--%>
<%--        </tr>--%>
        </tbody>
    </table>

    <br/><button id="registerBoard">새 글 등록</button>
    <br/><a href="/member">돌아가기</a>
</div>
</body>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        $.ajax({
            url: baseUrl + '/api/board/list',
            type: 'GET',
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (result) {
                console.log('success');

                $.each(result.data.boardList, function (key, obj) {
                    $('#tBodyBoardList').append($('<tr />', {
                        mouseover: function () {
                            $(this).css("background-color", "#f4f4f4");
                        },
                        mouseout: function () {
                            $(this).css("background-color", "#ffffff");
                        },
                        click: function () {
                            // console.log(obj.boardNo);
                            location.href = '/board/detail/' + obj.boardNo;
                        }
                    }).append($('<td />', {
                        text: obj.boardTitle
                    })).append($('<td />', {
                        text: obj.member.memberNm
                    })).append($('<td />', {
                        text: obj.regDate
                    })).append($('<td />', {
                        text: obj.boardViewCnt
                    })).append($('<td />', {
                        text: obj.boardRcmdCnt
                    })));
                });
            }, error: function (error) {
                console.log('error' + error);
            }
        });

        $('#registerBoard').on({
            click: function () {
                location.href = baseUrl + '/board/register';
            }
        });

    });
</script>
</html>