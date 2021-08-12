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
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />">
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
                <!-- Featured blog post-->
<%--                <div class="card mb-4">--%>
<%--                    <a href="#!"><img class="card-img-top" src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg"--%>
<%--                                      alt="..."/></a>--%>
<%--                    <div class="card-body">--%>
<%--                        <div class="small text-muted">January 1, 2021</div>--%>
<%--                        <h2 class="card-title">Featured Post Title</h2>--%>
<%--                        <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis--%>
<%--                            aliquid atque, nulla? Quos cum ex quis soluta, a laboriosam. Dicta expedita corporis animi--%>
<%--                            vero voluptate voluptatibus possimus, veniam magni quis!</p>--%>
<%--                        <a class="btn btn-primary" href="#!">Read more →</a>--%>
<%--                    </div>--%>
<%--                </div>--%>
                <!-- Nested row for non-featured blog posts-->
                <div class="row" id="divPost">

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
            <div class="col-lg-4">
                <!-- Categories widget-->
                <ul class="list-group" id="categoryList">
                    <li class="list-group-item d-flex justify-content-between align-items-center active" id="boardAll" onclick="location.href='/'">
                        전체
                        <span class="badge bg-primary rounded-pill" id="boardTotalCnt"></span>
                    </li>
                </ul><br>
                <!-- Search widget-->
                <div class="card mb-4">
                    <div class="card-header">Search</div>
                    <div class="card-body">
                        <div class="input-group">
                            <input class="form-control" type="text" placeholder="Enter search term..."
                                   aria-label="Enter search term..." aria-describedby="button-search"/>
                            <button class="btn btn-primary" id="button-search" type="button">Go!</button>
                        </div>
                    </div>
                </div>
                <!-- Side widget-->
                <div class="card mb-4">
                    <div class="card-header">Side Widget</div>
                    <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use,
                        and feature the Bootstrap 5 card component!
                    </div>
                </div>
            </div>
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

        addCategoryList('all');

        // 처음 화면 전체 게시물 리스트 출력
        addBoardListByCategory('all');

        $('#registerBoard').on({
            click: function () {
                location.href = baseUrl + '/board/register';
            }
        });

        // //카테고리 전체 탭
        $('#boardAll').off('click').on({
            click: function () {
                $(this).attr('class', 'list-group-item d-flex justify-content-between align-items-center active');
                $(this).siblings().attr('class', 'list-group-item d-flex justify-content-between align-items-center');

                addBoardListByCategory('all');
            }
        })
    });

</script>
</html>
