<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />

            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-2 section-heading">
                            <h2>Booking Detail</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3 mr-sm-2">Start Date</div>
                        <div class="col-sm-3 mr-sm-2">End Date</div>
                    </div>
                    <div class="row">
                        <!--searchBooking-->
                        <div class="col-sm-6" style="padding-bottom: 7px">
                            <form:form action="${pageContext.request.contextPath}/manager/find-booking" method="post" class="form-inline" modelAttribute="searchHistory" >
                                <input class="form-control" type="date" name="check_in"  aria-label="Search">
                                <input class="form-control" type="date"  name="check_out"  aria-label="xSearch">                                
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form:form>
                        </div>
                        <div class="col-sm-6" style="text-align: right;padding-bottom: 1px">
                            <h5><a href="<c:url value="/manager/pdf-view/${booking.id}"/>">Export Booking Detail</a></h5>
                        </div>
                    </div>          
                    <!--infor-->
                    <div class="row">
                        <div class="col-sm-12"><h2 class="text-monospace text-info mb-1" style="font-weight: bold;">Customer Name:  <c:out value="${booking.customerInfoEntity.fullName}"/></h2></div>
                        <div class="col-sm-5"><h3 class="text-monospace text-warning" style="font-weight: bold;">Check In: <fmt:formatDate pattern="dd/MM/yyyy" value="${booking.check_in}"/></h3></div>
                        <div class="col-sm-5"><h3 class="text-monospace text-warning" style="font-weight: bold;">Check Out: <fmt:formatDate pattern="dd/MM/yyyy" value="${booking.check_out}"/></h3></div>
                        <div class="col-sm-12 mb-2 mt-2" >
                            <h3 style="color: #08c">Booking Detail</h3>
                        </div>
                    </div>
                    <!--booking table-->
                    <div class="row">
                        <div class="col-sm-12" >
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <tr class="bg-dark text-white">
                                        <th class="text-center">Customer infor</th>
                                        <th class="text-center">Booking date</th>
                                        <th class="text-center">Check in</th>
                                        <th class="text-center">Check out</th>
                                        <th class="text-center">Room number</th>
                                        <th class="text-center">Room Price</th>
                                        <th class="text-center">Service</th>
                                        <th class="text-center">Service Price</th>

                                        <th class="text-center"> Price Detail</th>
                                    </tr>
                                    <c:forEach var="bookingDetail" items="${booking.bookingDetailEntities}">
                                        <tr> 
                                            <td>${booking.customerInfoEntity.fullName}</td>
                                            <td><fmt:formatDate type="date" value="${booking.booking_date}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate type="date" value="${booking.check_in}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate type="date" value="${booking.check_out}" pattern="dd/MM/yyyy" /></td>
                                            <td class="text-center"><c:out value="${bookingDetail.roomEntity.room_number}"/></td>
                                            <td class="text-center"><c:out value="${bookingDetail.roomEntity.roomCategory.price}"/></td>
                                            <c:if test="${empty bookingDetail.serviceEntities}"  >
                                                <td class="text-center"> No Service</td><td></td>
                                            </c:if>
                                            <c:if test="${not empty bookingDetail.serviceEntities}"  >
                                                <td class="text-center">
                                                    <c:forEach var="serv" items="${bookingDetail.serviceEntities}" >
                                                        ${serv.name},</c:forEach></td>
                                                    <td class="text-center">
                                                    <c:forEach var="serv" items="${bookingDetail.serviceEntities}" >
                                                        $${serv.price},</c:forEach></td>

                                            </c:if>
                                            <td class="text-center">$${bookingDetail.price}</td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="2"><h4 class="text-info">Total Price</h4></td>
                                        <td colspan="3" ><h3 class=" text-info">$${booking.total_price}</h3></td>
                                    </tr>

                                </table>
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
