// csrf
var token;
var header;
$(document).ready(function () {
    token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
});

// 선택된 카테고리에 active class 부과
function checkCategoryActive(value, categoryNo){
    if(value != categoryNo) {
        return 'list-group-item d-flex justify-content-between align-items-center'
    } else {
        return 'list-group-item d-flex justify-content-between align-items-center active'
    }
}

// 홈 사이드바 카테고리
function addCategoryList(value) {
    let cntAll = 0;
    $.ajax({
        url: baseUrl + '/api/category/list',
        type: 'GET',
        contentType: 'application/json',
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            $.each(result.data.categoryList, function (key, obj) {
                cntAll += obj.boardCnt;
                $('#categoryList').append($('<li />', {
                    class: checkCategoryActive(value, obj.categoryNo),
                    text: obj.categoryName,
                    value: obj.categoryNo,
                    id: obj.categoryNo,
                    click: function () {
                        $(this).attr('class', 'list-group-item d-flex justify-content-between align-items-center active');
                        $(this).siblings().attr('class', 'list-group-item d-flex justify-content-between align-items-center');
                        location.href = '/category/' + obj.categoryNo;
                    }
                }).append($('<span />', {
                    class: 'badge bg-primary rounded-pill',
                    text: obj.boardCnt
                })));
            });

            $('#boardTotalCnt').text(cntAll);

        }, error: function(error) {
            console.log('error')
        }
    });
}

// 메인 > 카테고리별 전체 게시물 리스트
function addBoardListByCategory(value) {
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
            // console.log('success');

            $('#divPost').empty();
            $.each(result.data.boardList, function (key, obj) {
                $('#divPost').append($('<div />', {
                    class: 'col-lg-6'
                }).append($('<div />', {
                    class: 'card mb-4'
                }).append($('<a />', {
                    href: '#!'
                })).append($('<img />', {
                    class: 'card-img-top',
                    src: "https://dummyimage.com/700x350/dee2e6/6c757d.jpg",
                    alt: "..."
                })).append($('<div />', {
                    class: 'card-body'
                }).append($('<div />', {
                    class: 'small text-muted',
                    text: dateFormat(obj.regDate)
                })).append($('<h2 />', {
                    class: 'card-title h4',
                    text: obj.boardTitle
                })).append($('<p />', {
                    class: 'card-text',
                    text: obj.memberId
                })).append($('<a />', {
                    class: 'btn btn-primary',
                    href: '/post/' + obj.categoryNo + '/' + obj.boardNo,
                    text: 'Read more →'
                })))))
            });
        }, error: function (error) {
            console.log('error' + error);
        }
    });
}

// 마이페이지 > 사용자가 작성한 게시물 리스트
function addBoardListMe(value) {
    $.ajax({
        url: baseUrl + '/api/board/list/me',
        type: 'GET',
        contentType: 'application/json',
        data: {
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
                    mouseover: function () {
                        $(this).css("background-color", "#f4f4f4");
                    },
                    mouseout: function () {
                        $(this).css("background-color", "#ffffff");
                    },
                    click: function () {
                        location.href = '/post/' + obj.categoryNo + '/' + obj.boardNo;
                    }
                }).append($('<th />', {
                    scope: 'row',
                    text: key
                })).append($('<td />', {
                    text: obj.boardTitle
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