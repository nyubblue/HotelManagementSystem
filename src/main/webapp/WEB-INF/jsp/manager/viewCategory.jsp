<%-- 
    Document   : standardRoom
    Created on : Jul 21, 2019, 6:12:59 PM
    Author     : HP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Room Category </title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 style="color: #08c">Category Rooms</h2>
                        </div>
                    </div>
                    <!--Success/fail-->
                    <c:if test="${messages!=null && messages!=''}">
                        <div class="row">
                            <div class="col-sm-12">
                                <c:if test="${status!=null && status=='success'}">
                                    <div class="alert alert-success">
                                        ${messages}
                                    </div>
                                </c:if>
                                <c:if test="${status!=null && status=='fail'}">
                                    <div class="alert alert-danger">
                                        ${messages}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <div class="row">
                        <!--search-->
                        <div class="col-sm-6" style="padding-bottom: 5px">
                            <form action="${pageContext.request.contextPath}/manager/searchCategory" method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" name="searchTxt" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <!--add-->
                        <div class="col-sm-6" style="text-align: right">
                            <button class="btn btn-info"
                                    onclick="location.href = '<c:url value="/manager/category"/>'">
                                Add Room Category</button>
                        </div>
                    </div> 
                    <!--showRoom-->
                    <div class="row">
                        <c:forEach var="category" items="${category}">
                            <div class="col-md-6 col-lg-4 mb-5">
                                <div class="hotel-room text-center">
                                    <c:if test="${category.imageEntities.size()>0}">
                                        <a href="<c:url value="detail-category/${category.id}"/>" class="d-block mb-0 thumbnail"><img src="<c:url value="/resources/images/${category.imageEntities.get(0).name}"/>" alt="Image"  title="category"class="img-fluid"></a>
                                        </c:if>
                                    <div class="hotel-room-body">
                                        <h3 class="heading mb-0"><a href="#">${category.name}</a></h3>
                                        <strong class="price">$${category.price} / per night</strong>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <!--If-No-Room-->
                        <div class="col-sm-6" >
                            <c:if test="${category==null || fn:length(category)<=0}">
                                <h5 style="color: red"
                                    cos >No Record</h5>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>
