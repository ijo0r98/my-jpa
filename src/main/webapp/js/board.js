// csrf
var token;
var header;
$(document).ready(function () {
    token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
});

// Li 카테고리 리스트
function addCategoryList(type, categoryNo) {
    $.ajax({
        url: baseUrl + '/api/category/list',
        type: 'GET',
        contentType: 'application/json',
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            // console.log('success');
            $.each(result.data.categoryList, function (key, obj) {
                $('#categoryList').append($('<li />', {
                    class: 'list-group-item list-group-item-action',
                    text: obj.categoryName,
                    value: obj.categoryNo,
                    click: function () {
                        $(this).attr('class', 'list-group-item list-group-item-action active');
                        $(this).siblings().attr('class', 'list-group-item list-group-item-action');
                        addBoardListByCategory($(this).val());
                    }
                }).append($('<span />', {
                    class: 'badge badge-primary badge-pill',
                    text: obj.boardCnt
                })));
            })
        }, error: function(error) {
            console.log('error')
        }
    });
}

// 카테고리별 전체 게시물 리스트
function addBoardListByCategory(value) {
    if(value === 'all') {
        $.ajax({
            url: baseUrl + '/api/board/list',
            type: 'GET',
            contentType: 'application/json',
            beforeSend : function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (result) {
                console.log('success');

                $('#tBodyBoardList').empty();
                $.each(result.data.boardList, function (key, obj) {
                    $('#tBodyBoardList').append($('<tr />', {
                        mouseover: function () {
                            $(this).css("background-color", "#f4f4f4");
                        },
                        mouseout: function () {
                            $(this).css("background-color", "#ffffff");
                        },
                        click: function () {
                            location.href = '/board/detail/' + obj.boardNo;
                        }
                    }).append($('<td />', {
                        text: obj.boardTitle
                    })).append($('<td />', {
                        text: obj.member.memberId
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
    } else {
        $.ajax({
            url: baseUrl + '/api/board/list/' + value,
            type: 'GET',
            contentType: 'application/json',
            beforeSend : function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (result) {
                // console.log('success');

                $('#tBodyBoardList').empty();
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
}