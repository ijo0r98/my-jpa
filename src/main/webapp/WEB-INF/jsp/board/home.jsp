<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>JPA</title>
    <!-- Favicon-->
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
</head>
<body>
<style>
    table th {
        text-align: center;
    }
</style>

<jsp:include page="../navigation.jsp" flush="false"/>

<header class="py-5 bg-light border-bottom mb-4">
    <div class="container">
        <div class="text-center my-5">
            <h1 class="fw-bolder">Welcome to Blog Home!</h1>
            <p class="lead mb-0">A Bootstrap 5 starter layout for your next blog homepage</p>
        </div>
    </div>
</header>

<sec:authorize access="isAnonymous()">
    <jsp:include page="../anonymous.jsp" flush="false"/>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <sec:csrfMetaTags />
    <!-- Page content-->
    <div class="container">
        <div class="row">
            <!-- Blog entries-->
            <div class="col-lg-8">
                <div class="row" id="divPost">
                    <c:forEach var="board" items="${boardList}" varStatus="status">
                        <div class="col-lg-6">
                            <div class="card mb-4">
                                <img class="card-img-top" src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="img">
                                <div class="card-body">
                                    <div class="small text-muted">${board.regDate}</div>
                                    <h2 class="card-title h4">${board.boardTitle}</h2>
                                    <p class="card-text">${board.memberName}</p>
                                    <a class="btn btn-primary" href="/board/${board.categoryNo}/${board.boardNo}">Read more →</a></div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination-->
                <nav aria-label="Pagination">
                    <hr class="my-0"/>
                    <ul class="pagination justify-content-center my-4">
                        <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Newer</a>
                        </li>
                        <li class="page-item active" aria-current="page"><a class="page-link" href="#!">1</a></li>
                        <li class="page-item"><a class="page-link" href="#!">2</a></li>
                        <li class="page-item"><a class="page-link" href="#!">3</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#!">...</a></li>
                        <li class="page-item"><a class="page-link" href="#!">15</a></li>
                        <li class="page-item"><a class="page-link" href="#!">Older</a></li>
                    </ul>
                </nav>
            </div>
            <!-- Side widgets-->
            <jsp:include page="../side.jsp" flush="false"/>
        </div>
    </div>

</sec:authorize>

<jsp:include page="../footer.jsp" flush="false"/>

</body>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/board.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('#registerBoard').on({
            click: function () {
                location.href = baseUrl + '/board/register';
            }
        });

        if (parseInt(${categoryNo}) >= 1) {
            $('#categoryList li').eq(${categoryNo}).attr('class', 'list-group-item d-flex justify-content-between align-items-center active');
        } else {
            $('#categoryList li').eq(0).attr('class', 'list-group-item d-flex justify-content-between align-items-center active');
        }
    });

</script>
</html>
