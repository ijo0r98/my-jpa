<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>DropzoneJS 이미지 전송</title>
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
  </head>
  <body>
  <div>
    <form class="dropzone" id="dropzone-file" enctype="multipart/form-data" method="POST" action="/test/upload">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div class="dz-message needsclick"> Drop files here or click to upload </div>
      <div class="fallback">
        <input name="imageV1" type="file" multiple="multiple">
      </div>
      <input type="button" id="submit" value="전송"/>
    </form>
  </div>
  </body>
</html>
<script>
  var dropzoneFile = new Dropzone("#dropzone-file",{
    url:'upload',
    maxFilesize:5000000000,
    parallelUploads:5, //한번에 올릴 파일 수
    addRemoveLinks: true, //업로드 후 삭제 버튼
    timeout:300000, //커넥션 타임아웃 설정
    maxFiles:5, //업로드 할 최대 파일 수
    paramName: "file", //파라미터로 넘길 변수명 default는 file
    autoQueue: false, //드래그 드랍 후 바로 서버로 전송
    createImageThumbnails:true, //파일 업로드 썸네일 생성
    uploadMultiple:true, //멀티파일 업로드
    dictRemoveFile:'삭제', //삭제 버튼의 텍스트 설정
    dictDefaultMessage:'PREVIEW', //미리보기 텍스트 설정
    accept:function(file,done){
      //validation을 여기서 설정하면 된다.
      // 설정이 끝나고 꼭 done()함수를 호출해야 서버로 전송한다.
      done();
      },
    init:function(){
      var myDropzone = this;
      $('#submit').on("click", function(e) {
          myDropzone.processQueue();
      });

    },
  });


</script>