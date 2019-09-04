<%-- 
    Document   : form-add-room
    Created on : Jul 21, 2019, 10:20:46 PM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Detail</title>
        <jsp:include page="../include/header.jsp" />
        <style>
            .ui-error{
                color: red
            }
        </style>
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 style="color: #08c">Room Detail</h2>
                        </div>
                    </div>
                    <div class="row">
                        <!--search-->
                        <div class="col-sm-6" style="padding-bottom: 5px">
                            <form action="${pageContext.request.contextPath}/manager/search" method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" name="searchTxt" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <!--add-->
                        <div class="col-sm-6" style="text-align: right">
                            <button class="btn btn-info"
                                    onclick="location.href = '<c:url value="/manager/form-add-room"/>'">
                                Add Room</button>
                        </div>
                    </div>    
                    <div class="row">
                        <!--list room-->
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th>Category</th>
                                            <th>Room_Number</th>
                                            <th>Create Date</th>
                                            <th>Number of Bed</th>
                                            <th>Convenience</th>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        <tr>
                                            <td>${room.roomCategory.name}</td>
                                            <td>${room.room_number}</td>
                                            <td>${room.createAT}</td>
                                            <td>${room.roomCategory.number_of_bed}</td>
                                            <td>${room.roomCategory.convenience}</td>
                                            <td>${room.roomCategory.description}</td>
                                            <td>$${room.roomCategory.price}</td>
                                            <td>${room.roomCategory.status}</td>
                                            <!--action-->
                                            <td>
                                                <button  class="btn btn" style="color: green"
                                                         onclick="location.href = '<c:url value="/manager/update-form/${room.id}"/>'">
                                                    Update</button>
                                            </td>
                                        </tr>
                                    </table>
                                    <!--list image-->
                                    <div class="row">
                                        <c:forEach var="images" items="${images}">
                                            <div class="col-md-6 col-lg-4 mb-5">
                                                <div class="hotel-room text-center">
                                                    <a href="#" class="d-block mb-0 thumbnail"><img src="<c:url value="/resources/images/${images.name}"/>" 
                                                                                                    alt="${room.room_number}" title="${room.room_number}" width="350" height="250"></a>
                                                    <div class="hotel-room-body">
                                                        <h3 class="heading mb-0"><a href="">${room.room_number}</a></h3>
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
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>