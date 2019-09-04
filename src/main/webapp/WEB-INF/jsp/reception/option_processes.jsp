<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reception</title>
        <jsp:include page="../include/header.jsp"></jsp:include>
        <jsp:include page="../include_b/header-css.jsp"></jsp:include>
        <s:url var="url_jqlib" value="/resources_b/js/jquery-3.3.1.min.js" />
        <s:url var="url_bg" value="/resources_b/images/bg.jpg" />
        <style>
            body {
                background-image: url("${url_bg}");
                font-family: arial;
                font-size : 130%;
            }
            .bk{
                width: 180px;
                height: 54px;
                background: white;
                border-radius: 15px;
            }

        </style>
        <script src="${url_jqlib}"></script>
        <script>
            $(document).ready(function () {
                var from = $("#from").val();
                var to = $("#to").val();

                $("#from").datepicker({
                    minDate: 0,
                    maxDate: "+60D",
                    numberOfMonths: 2,
                    onSelect: function (selected) {
                        $("#to").datepicker("option", "minDate", selected);
                    }
                });
                $("#to").datepicker({
                    minDate: 0,
                    maxDate: "+60D",
                    numberOfMonths: 2,
                    onSelect: function (selected) {
                        $("#from").datepicker("option", "maxDate", selected);
                    }
                });

                //            if (Date.parse(from) > Date.parse(to)) {
                //                alert("Invalid Date Range");
                //            } else {
                //                alert("Valid date Range");
                //            }
            });
        </script>
    </head>
    <body >
        <div class="site-wrap" >
            <div class="site-navbar-wrap js-site-navbar bg-white scrolled">
                <div class="container">
                    <div class="site-navbar bg-light">
                        <div class="py-1">
                            <div class="row align-items-center">
                                <div class="col-12">
                                    <nav class="site-navigation text-right" role="navigation">
                                        <div class="container">
                                            <div class="d-inline-block d-lg-none  ml-md-0 mr-auto py-3"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu h3"></span></a></div>
                                            <ul class="site-menu js-clone-nav d-none d-lg-block">

                                                <sec:authorize access="isAuthenticated()">
                                                    <li class="active">
                                                        <a href="<c:url value="/reception/home" />">Home</a>
                                                    </li>
                                                </sec:authorize>
                                                <sec:authorize access="!isAuthenticated()">
                                                    <li class="active">
                                                        <a href="<c:url value="/home" />">Home</a>
                                                    </li>
                                                </sec:authorize>
                                                <sec:authorize access="isAuthenticated()">

                                                    <li>  <a href="<c:url value="/logout" />">Logout</a></li>  
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                    <li><a href="<c:url value="/login" />">Login</a></li>
                                                    <li><a href="<c:url value="/register" />">Register</a></li>  
                                                    </sec:authorize>
                                            </ul>
                                        </div>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="slide-one-item home-slider owl-carousel">
                <div class="site-blocks-cover overlay" style="background-image: url(<s:url value="/resources/images/hero_1.jpg"/>);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">

                                <h1 class="mb-2">Welcome To Suites</h1>
                                <h2 class="caption">Hotel &amp; Resort</h2>
                            </div>
                        </div>
                    </div>
                </div>  

                <div class="site-blocks-cover overlay" style="background-image: url(<s:url value="/resources/images/hero_2.jpg"/>);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Relaxing Room</h1>
                                <h2 class="caption">Your Room, Your Stay</h2>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>

            <!--content-->
            <div class="container" >
                <div class="row">
                    <div class="col-sm-12 mx-auto text-center mb-6 section-heading">
                        <div><h2 class="mb-5">Booking Information</h2></div>
                    </div>
                    <div class="col-sm-12">

                        <div class="ml-4"> <h3 class="text-info">Customer :   ${booking.customerInfoEntity.fullName}</h3></div>
                        <div class="ml-4"><h3>Booking Code :   ${booking.id}</h3></div>
                        <div class="ml-4"><h3>Check In :   ${booking.check_in}</h3></div>
                        <div class=" ml-4 mb-4 "><h3>Check Out :   ${booking.check_in}</h3></div>

                    </div>
                    <div class="col-sm-12 mb-3">
                        <div class="col-sm-6 offset-6">
                            <c:if test="${booking.status == 'ORDERED'}">
                                <button   
                                                onclick='location.href = "<c:url value="/reception/check_info/${booking.customerInfoEntity.id}/${booking.id}"/> "'
                                                type="button" class="btn btn-success">
                                    Check In Room</button>
                            </c:if>
                            <c:if test="${booking.status == 'IN'}">
                                <button   
                                                onclick='location.href = "<c:url value="/reception/check_info/${booking.customerInfoEntity.id}/${booking.id}"/> "'
                                                type="button" class="btn btn-success">
                                    Check Out Room</button>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <table class="table table-bordered bg-light">
                            <thead class="bg-dark text-white">
                                <tr>
                                    <th>Room</th>
                                    <th>Description</th>
                                    <th>Services</th>
                                    <th>Price</th>
                                    <th>Option</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${booking.bookingDetailEntities}" >
                                    <tr>

                                        <td>
                                            <div>
                                                <img width="300" height="400"
                                                     src='<s:url value="/resources/images/${detail.roomEntity.roomCategory.imageEntities[0].name}" />'
                                                     class="figure-img img-fluid rounded" alt="atl">
                                            </div>
                                            <div>
                                                <h3 class="text-center">${detail.roomEntity.room_number}</h3>
                                            </div>
                                        </td>

                                        <td>
                                            <div>
                                                <h2 class="text-center" style="font-weight: bold;"> ${detail.roomEntity.roomCategory.name}</h2>
                                                <p class="text-center text-dark mb-2">___________________________</p>
                                                <c:forEach var="des" items="${detail.roomEntity.roomCategory.descriptions}">
                                                    <h5 class="text-dark"><span class="text-info">&#10021;</span> ${des}</h5>
                                                </c:forEach>
                                            </div>
                                        </td>

                                        <td>
                                            <form:form action="${pageContext.request.contextPath}/reception/addService" modelAttribute="serviceForm" method="post">
                                                <div class="mb-2">
                                                    <select  name="servId"
                                                             class="custom-select">
                                                        <option selected>Select Service</option>
                                                        <c:if test="${empty detail.serviceEntities}">
                                                            <c:forEach var="serv" items="${services}">
                                                                <option value="${serv.id}">${serv.name}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${not empty detail.serviceEntities}">
                                                            <c:forEach var="serv" items="${detail.serviceShow}">
                                                                <option value="${serv.id}">${serv.name}</option>
                                                            </c:forEach>
                                                        </c:if>

                                                    </select>
                                                </div>
                                                <input  name="roomId"
                                                        value="${detail.id}" hidden="true" />
                                                <button  class="btn btn-primary" type="submit">Update Services</button>

                                            </form:form>
                                            <c:if test="${empty detail.serviceEntities}" >
                                                <div class="alert alert-info mt-4" role="alert"> 
                                                    No Service
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty detail.serviceEntities}">
                                                <div class="alert alert-success mt-4" role="alert"> 
                                                    <c:forEach var="service" items="${detail.serviceEntities}">
                                                        <div class="d-flex">
                                                            <div class="flex-fill justify-content-start">
                                                                ${service.name}</div> 
                                                            <div class="flex-fill justify-content-end">
                                                                <button type="button" class="close" aria-label="Close"
                                                                        onclick='location.href = "<c:url value="/reception/deleteServ/${service.id}/${detail.id}" /> "'>
                                                                    <span  aria-hidden="true">&times;</span>
                                                                </button> 
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>

                                        </td>

                                        <td><h3>$${detail.price}</h3></td>
                                        <td>
                                            <s:url  var="url_a" value = "/reception/deleteDetail/${detail.id}" />
                                             <button 
                                                onclick='location.href = "${url_a}"'
                                                type="button" class="btn btn-danger">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-dark text-white">
                                <tr>

                                    <td colspan="5" >
                                        <div class="d-flex justify-content-center"><h2 class=" text-white ">Total Price        $${booking.total_price}</h2></div>

                                    </td>
                                </tr>
                            </tfoot>
                        </table> 
                    </div>

                </div>
            </div>

            <div class="py-5 quick-contact-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <div>
                                <span class="icon-room text-white h2 d-block"></span>
                                <h2>Location</h2>
                                <p class="mb-0">New York - 2398 <br>  10 Hadson Carl Street</p>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div>
                                <span class="icon-clock-o text-white h2 d-block"></span>
                                <h2>Service Times</h2>
                                <p class="mb-0">Wednesdays at 6:30PM - 7:30PM <br>
                                    Fridays at Sunset - 7:30PM <br>
                                    Saturdays at 8:00AM - Sunset</p>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div>
                                <span class="icon-comments text-white h2 d-block"></span>
                                <h2>Get In Touch</h2>
                                <p class="mb-0">Email: info@yoursite.com <br>
                                    Phone: (123) 3240-345-9348 </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
        <jsp:include page="../include_b/footer-script.jsp"/>
    </body>
</html>
