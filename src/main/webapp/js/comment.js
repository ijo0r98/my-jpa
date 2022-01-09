// csrf
var token;
var header;
$(document).ready(function () {
    token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
});

// 마이페이지 > 사용자가 작성한 댓글 리스트
function addCommentListMe(value) {
    $.ajax({
        url: baseUrl + '/api/comment/list/me',
        type: 'GET',
        contentType: 'application/json',
        data: {
            categoryNo : value,
        },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            $('#tBodyCommentList').empty();
            $.each(result.data.commentList, function (key, obj) {
                $('#tBodyCommentList').append($('<tr />', {
                    class: 'table-light',
                    mouseover: function () {
                        $(this).css("background-color", "#f4f4f4");
                    },
                    mouseout: function () {
                        $(this).css("background-color", "#ffffff");
                    },
                    click: function () {
                        location.href = '/board/' + obj.categoryNo + '/' + obj.boardNo;
                    }
                }).append($('<th />', {
                    scope: 'row',
                    text: key
                })).append($('<td />', {
                    text: obj.boardTitle
                })).append($('<td />', {
                    text: obj.commentContent
                })).append($('<td />', {
                    text: dateFormat(obj.regDate)
                })));
            });
        }, error: function (error) {
            console.log(error)
        }
    });
}