<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
        <jsp:include page="../include/header.jsp" />
        <style>
            body{
                font-size: 120%;
            }
            td,th{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="site-wrap">

            <div class="site-menu-toggle js-site-navbar bg-white">
                <div class="container">
                    <div class="site-navbar bg-light">
                        <div class="py-1">
                            <div class="row align-items-center">
                                <div class="col-12">
                                    <nav class="site-navigation text-right" role="navigation">
                                        <div class="container">
                                            <div class="d-inline-block d-lg-none  ml-md-0 mr-auto py-3"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu h3"></span></a></div>
                                            <ul class="site-menu js-clone-nav d-none d-lg-block">
                                                <li >
                                                    <a href="<c:url value="/user/home" />">Home</a>
                                                </li>
                                                <li><a href="<c:url value="/user/profile" />">Profile</a></li>
                                                <li><a href="<c:url value="/user/view_history" />">History</a></li>
                                                <li><sec:authorize access="isAuthenticated()">                                                                                                                    
                                                    <a href="<c:url value="/logout" />">LOGOUT</a>
                                                </sec:authorize>
                                                </li>
                                            </ul>
                                        </div>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12"><h2 class="text-monospace text-info mb-1" style="font-weight: bold;">Customer Name:  <c:out value="${booking.customerInfoEntity.fullName}"/></h2></div>
                        <div class="col-sm-5"><h3 class="text-monospace text-warning" style="font-weight: bold;">Check In: <fmt:formatDate pattern="dd/MM/yyyy" value="${booking.check_in}"/></h3></div>
                        <div class="col-sm-5"><h3 class="text-monospace text-warning" style="font-weight: bold;">Check Out: <fmt:formatDate pattern="dd/MM/yyyy" value="${booking.check_out}"/></h3></div>
                        <div class="col-sm-12 mb-2 mt-2" >
                            <h3>Booking Detail</h3>
                        </div>
                    </div>
                    <!--product table-->
                    <div class="row">
                        <div class="col-sm-10">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <tr style="background: graytext; color:whitesmoke;">
                                        <th>Category</th>
                                        <th>Room Number</th>
                                        <th>Services</th>
                                        <th>Price</th>
                                    </tr>
                                    <c:forEach var="bookingDetail" items="${booking.bookingDetailEntities}" varStatus="ss">
                                        <tr>
                                            <td><c:out value="${bookingDetail.roomEntity.roomCategory.name}"/></td>
                                            <td><c:out value="${bookingDetail.roomEntity.room_number}"/></td>
                                            <td>
                                                <c:if test="${empty bookingDetail.serviceEntities}"  >
                                                    No Service
                                                </c:if>
                                                <c:if test="${not empty bookingDetail.serviceEntities}"  >
                                                    <c:forEach var="serv" items="${bookingDetail.serviceEntities}" >
                                                        <p>${serv.name}</p>
                                                    </c:forEach>
                                                </c:if>

                                            </td>
                                            <td><fmt:formatNumber value = "${bookingDetail.price}" type = "currency"/></td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="bg-dark">
                                        <td><h3 class="text-white">Total Price</h3></td>
                                        <td colspan="3" ><h3 class="text-center text-white"><fmt:formatNumber value = "${booking.total_price}" type = "currency"/></h3></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <button class="btn btn-success " style="color: whitesmoke; width: 100px" 
                                    onclick="location.href = '<c:url value="/user/downExel/${booking.id}"/>'">
                                Export</button>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>