<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Booking</title>
        <jsp:include page="../include/header.jsp" />
        <style>
            body{ font-family:Arial;}
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
                        <div class="col-sm-12" style="text-align: center">
                            <h2 class="text-monospace">Booking History</h2>
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
                        <!--searchBooking-->
                        <div class="col-sm-6" style="padding-bottom: 7px">
                            <form:form action="${pageContext.request.contextPath}/user/search_history" method="post" class="form-inline" modelAttribute="searchHistory" >
                                <input class="form-control" type="date" name="startDate"  aria-label="Search">
                                <input class="form-control" type="date"  name="endDate"  aria-label="xSearch">                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form:form>
                        </div>
                    </div>                  
                    <!--product table-->
                    <div class="row">
                        <div class="col-sm-12" >
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <tr class="bg-dark text-white">
                                        <th class="text-center">Customer</th>
                                        <th class="text-center">Booking Date</th>
                                        <th class="text-center">Check in</th>
                                        <th class="text-center">Check out</th>
                                        <th class="text-center">Total Price</th>
                                        <th colspan="2" class="text-center">Action</th>
                                    </tr>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr> 
                                            <td class="text-center">${booking.customerInfoEntity.fullName}</td>
                                            <td class="text-center"><fmt:formatDate type="date" value="${booking.booking_date}" pattern="dd/MM/yyyy" /></td>
                                            <td class="text-center"><fmt:formatDate type="date" value="${booking.check_in}" pattern="dd/MM/yyyy" /></td>
                                            <td class="text-center"><fmt:formatDate type="date" value="${booking.check_out}" pattern="dd/MM/yyyy" /></td>
                                            <td class="text-center">${booking.total_price}</td>

                                            <td class="text-center">

                                                <button class="btn btn-primary " style="color: whitesmoke; width: 100px" 
                                                        onclick="location.href = '<c:url value="detail/${booking.id}"/>'">
                                                    Detail</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty bookings}">
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
