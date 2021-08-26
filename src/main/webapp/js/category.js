// csrf
var token;
var header;
$(document).ready(function () {
    token = $("meta[name='_csrf']").attr("content");
    header = $("meta[name='_csrf_header']").attr("content");
});

// 새로운 카테고리 추가
function addCategory(categoryName) {
    $.ajax({
        url: baseUrl + '/api/category/add',
        type: 'POST',
        contentType: 'application/json',
        headers: {
            "X-CSRF-TOKEN": token
        },
        data: JSON.stringify({
            'categoryName': categoryName
        }),
        success: function (result) {
            // console.log(result);
            location.reload();
        }, error: function (error) {
            console.log('error');
        }
    });
}

// 기존의 카테고리 삭제
function deleteCategory(categoryNo) {
    $.ajax({
        url: baseUrl + '/api/category/delete/' + categoryNo,
        type: 'GET',
        beforeSend: function (xhr) {
            xhr.setRequestHeader(token, header);
        },
        success: function (result) {
            // console.log(result);
            location.reload();
        }, error: function (error) {
            // console.log(error);
        }
    });
}

function editCategory() {

}

// 등록된 카테고리 리스트
function addCategoryListAdmin() {
    $.ajax({
        url: baseUrl + '/api/category/list',
        type: 'GET',
        contentType: 'application/json',
        success: function (result) {
            $('#tBodyCategoryList').empty();
            $.each(result.data.categoryList, function (key, obj) {
                $('#tBodyCategoryList').append($('<tr />', {
                    class: 'table-light',
                }).append($('<th />', {
                    text: key + 1,
                    scope: 'row',
                })).append($('<td />', {
                    text: obj.categoryName
                })).append($('<td />', {
                    text: obj.boardCnt
                })).append($('<td />').append($('<button />', {
                    text: '수정',
                    class: 'badge bg-light'
                }))).append($('<td />').append($('<button />', {
                    text: '삭제',
                    class: 'badge bg-light'
                }))));
            });
        }, error: function (error) {
            console.log(error);
        }
    });
}