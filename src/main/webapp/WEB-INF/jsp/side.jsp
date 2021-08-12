<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="col-lg-4">
    <!-- Categories widget-->
    <ul class="list-group" id="categoryList">
        <li class="list-group-item d-flex justify-content-between align-items-center" id="boardAll" onclick="location.href='/'">
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

<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/jquery-1.12.4.js"/> "></script>
<script type="text/javascript" src="<c:url value="/js/board.js"/> "></script>
<script type="text/javascript">
    $(document).ready(function () {

        addCategoryList(${categoryNo});

    });
</script>