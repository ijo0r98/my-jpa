// csrf
var token;
var header;
$(document).ready(function () {
    token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
});

function checkCategoryActive(value, categoryNo){
    if(value != categoryNo) {
        return 'list-group-item d-flex justify-content-between align-items-center'
    } else {
        return 'list-group-item d-flex justify-content-between align-items-center active'
    }
}

// 카테고리 리스트
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
            // console.log('success');

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
                        src:"https://dummyimage.com/700x350/dee2e6/6c757d.jpg",
                        alt:"..."
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
                        text: obj.member.memberId
                    })).append($('<a />', {
                        class: 'btn btn-primary',
                        href: '/post/' + obj.category.categoryNo +'/' + obj.boardNo,
                        text: 'Read more →'
                    })))))
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
                console.log(result.data.boardList);

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
                        src:"https://dummyimage.com/700x350/dee2e6/6c757d.jpg",
                        alt:"..."
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
                        text: obj.memberNm
                    })).append($('<a />', {
                        class: 'btn btn-primary',
                        href: '/post/' + obj.categoryNo +'/' + obj.boardNo,
                        text: 'Read more →'
                    })))));
                });
            }, error: function (error) {
                console.log('error' + error);
            }
        });
    }
}