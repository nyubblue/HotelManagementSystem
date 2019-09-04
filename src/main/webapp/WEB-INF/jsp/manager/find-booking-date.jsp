<%-- 
    Document   : standardRoom
    Created on : Jul 21, 2019, 6:12:59 PM
    Author     : HP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Booking</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />

            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mx-auto text-center mb-2 section-heading ">
                            <h2 style="color: #08c">Booking From <fmt:formatDate type="date" value="${check_in}" pattern="dd-MM-yyyy" />
                                To <fmt:formatDate type="date" value="${check_out}"/></h2>

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
                        <div class="col-sm-3 mr-sm-2">Start Date</div>
                        <div class="col-sm-3 mr-sm-2">End Date</div>
                    </div>
                    <div class="row">
                        <!--searchBooking-->
                        <div class="col-sm-12" >
                            <form action="${pageContext.request.contextPath}/manager/find-booking" method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" type="date" name="check_in" placeholder="Check_in (yyyy-MM-dd)" aria-label="Search">
                                <input class="form-control mr-sm-2" type="date" name="check_out" placeholder="Check_out (yyyy-MM-dd)" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <!--report booking date-->
                        <div class="col-sm-12 text-right" >
                            <h5><a href="<c:url value="downloadExcel" />">Export Excel</a></h5>
                        </div>
                    </div>                  
                    <!--product table-->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Booking Date</th>
                                        <th>Check in</th>
                                        <th>Check out</th>
                                        <th>Total Price</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                        <th colspan="2">Update Status</th>
                                    </tr>
                                    <c:forEach var="booking" items="${booking}">
                                        <tr>
                                            <td><fmt:formatDate type="date" value="${booking.booking_date}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate type="date" value="${booking.check_in}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate type="date" value="${booking.check_out}" pattern="dd/MM/yyyy" /></td>

                                            <td>${booking.total_price}</td>
                                            <td>${booking.status}</td>
                                            <!--<!--action(update/delete)-->
                                            <td>

                                                <button class="btn btn-info " style="color: whitesmoke; width: 100px" 
                                                        onclick="location.href = '<c:url value="booking-detail/${booking.id}"/>'">
                                                    Detail</button>

                                            </td>
                                            <form:form action="${pageContext.request.contextPath}/manager/update-status/${booking.id}" method="post" 
                                                       class="form-horizontal" >
                                                <td>
                                                    <select name="status" class="form-control">
                                                        <option value="done" selected>DONE</option>
                                                        <option value="in" selected>IN</option>
                                                        <option value="order" selected>ORDERED</option>
                                                    </select>

                                                </td>
                                                <td>
                                                    <button class="btn btn-outline-success  text-center" 
                                                            type="submit">Update</button>
                                                </td>
                                            </form:form>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${booking==null || fn:length(booking)<=0}">
                                        <tr>
                                            <td style="color: red"
                                                colspan="7">No records</td>
                                        </tr>
                                    </c:if>
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
