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
        <title>Detail Room Category</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 style="color: #08c">Room category detail</h2>
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
                            <form action="${pageContext.request.contextPath}/manager/searchCategory" 
                                  method="post" class="form-inline"  >
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
                    <!--detail-->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Name</th>
                                        <th>Price</th>
                                        <th>Number Of Bed</th>
                                        <th>Size</th>
                                        <th>Convenience</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                        <th>Update Status</th>
                                    </tr>
                                    <tr>
                                        <td>${category.name}</td>
                                        <td>$${category.price}</td>
                                        <td>${category.number_of_bed}</td>
                                        <td>${category.sizeRoom}</td>
                                        <td>${category.convenience}</td>
                                        <c:if test="${category.status == 'UnAvailable'}">
                                            <td style="color: red">${category.status}</td></c:if>
                                        <c:if test="${category.status == 'Available'}">
                                            <td style="color: blue">${category.status}</td></c:if>
                                            <td>
                                                <button  class="btn btn" style="color: green"
                                                         onclick="location.href = '<c:url value="/manager/update-form-category/${category.id}"/>'">
                                                Update</button>
                                        </td>
                                        <c:if test="${category.status == 'UnAvailable'}">
                                            <td style="color: red"><button  class="btn btn-info" style="color: #FFFF99"
                                                                            onclick="location.href = '<c:url value="/manager/active-category/${category.id}"/>'">
                                                    Available</button></td></c:if>
                                                <c:if test="${category.status == 'Available'}">
                                            <td style="color: blue"><button  class="btn btn-block" style="color: #c7180c"
                                                                             onclick="location.href = '<c:url value="/manager/block-category/${category.id}"/>'">
                                                    UnAvailable</button></td></c:if>
                                        </tr>
                                    </table>
                                    <!--show image-->
                                    <div class="row">
                                    <c:forEach var="images" items="${images}">
                                        <div class="col-md-6 col-lg-4 mb-5">
                                            <div class="hotel-room text-center">
                                                <a href="#" class="d-block mb-0 thumbnail">
                                                    <img src="<c:url value="/resources/images/${images.name}"/>" 
                                                         alt="${images.name}" title="${images.name}" width="400" height="300">
                                                </a>
                                                <div class="hotel-room-body">
                                                    <h3 class="heading mb-0"><a href="">${category.name}</a></h3>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>                                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>
