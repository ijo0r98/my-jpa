<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Form 태그를 이용한 파일 전송</title>
  </head>
  <body>
    <form name="form" method="post" action="/test/image/V1/api" enctype="multipart/form-data">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <input type="file" name="imageV1" multiple="multiple"/>
      <input type="submit" id="submit" value="전송"/>
    </form>
  </body>
</html>
