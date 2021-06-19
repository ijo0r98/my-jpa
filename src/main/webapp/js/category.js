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
        data: JSON.stringify({
            'categoryName': categoryName
        }),
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