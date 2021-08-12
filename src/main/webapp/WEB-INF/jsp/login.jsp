<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
</head>
<body>

<jsp:include page="navigation.jsp" flush="false"/>

<!-- Content section-->
<div class="py-lg-5">
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="form-group">
                    <label class="form-label mt-4">이메일과 비밀번호를 입력해 주세요</label>
                    <form action="/login" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingInput" placeholder="name@example.com" name="username">
                            <label for="floatingInput">Email address</label>
                        </div>
                        <div class="form-floating">
                            <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password">
                            <label for="floatingPassword">Password</label>
                        </div>
                        <div>
                            <c:if test="${not empty errorMsg}">
                                ${errorMsg}
                            </c:if>
                        </div>
                        <br/>
                        <button type="submit" class="btn btn-secondary align-content-center" >로그인</button>
                    </form>

                    <br/>
                    <br/>

                    아직 회원이 아니라면 이곳을 눌러주세요 &nbsp; <a href="/signup">click!</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" flush="false"/>

</body>
</html>