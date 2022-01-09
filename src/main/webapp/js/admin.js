// csrf
var token;
var header;
$(document).ready(function () {
    token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
});

// 게시물 관리 > 카테고리별 게시물 조회
function addBoardListAdmin(value) {
    $.ajax({
        url: baseUrl + '/api/board/list',
        type: 'GET',
        contentType: 'application/json',
        data:{
            categoryNo: value,
        },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            $('#tBodyBoardList').empty();
            $.each(result.data.boardList, function (key, obj) {
                $('#tBodyBoardList').append($('<tr />', {
                    class: 'table-light',
                    click: function () {
                        location.href = '/board/' + obj.categoryNo + '/' + obj.boardNo;
                    }
                }).append($('<th />', {
                    scope: 'row',
                    text: key + 1
                })).append($('<td />', {
                    text: obj.boardTitle
                })).append($('<td />', {
                    text: obj.memberId
                })).append($('<td />', {
                    text: dateFormat(obj.regDate)
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
}