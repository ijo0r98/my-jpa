<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>title</title>
</head>
<body>
<button type="button" id="btnAdd">더하기</button>
<button type="button" id="btnMinus">빼기</button>
<button type="button" id="btnDivide">나누기</button>
<button type="button" id="btnMultiply">곱하기</button>
<button type="button" onclick="function_name()">button</button> <!--onclick 보다는 jQuery 주로 사용-->

<!-- JQuery -->
<script type="text/javascript" src="../../js/jquery-1.12.4.js"></script>
<!-- JavaScript -->
<script type="text/javascript">
    // alert('hello world');

    // 즉시 함수 실행 jQeury
    $(document).ready(function() {
        // 실행할 함수 호출
        // jquery 밖에서 함수 만들어야 함
        // function_name(parameter);
    });

    function function_name(parameter) {
        // 함수 기능
    }

    // $  jquery에서 변수 사용
    // $('.className')  class 프론트엔드 개발
    // $('#idName')  id 백엔드 개발

    $(document).ready(function () {
        $('#btnAdd').on({
            click: function (params) {
                alert(add(1, 2));
                console.log(add(1,2));
            }
        });

        $('#btnMinus').on({
            click: function (params) {
                alert(minus(1, 2));
                console.log(minus(1,2));
            }
        });

        $('#btnMultiply').on({
            click: function (params) {
                alert(multify(1, 2));
                console.log(multify(1,2));
            }
        });

        $('#btnDivide').on({
            click: function (params) {
                alert(divide(1, 2));
                console.log(divide(1, 2));
            }
        });
    });

    function add(x, y) {
        return eval(x) + eval(y);
    }

    function minus(x, y) {
        return eval(x) - eval(y);
    }

    function divide(x, y) {
        return eval(x) / eval(y);
    }

    function multify(x, y) {
        return eval(x) * eval(y);
    }

</script>
</body>
</html>
