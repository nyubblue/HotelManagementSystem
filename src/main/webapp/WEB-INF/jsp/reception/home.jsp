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
        <style>
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
    <body>
        <div class="site-wrap">
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
                <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/hero_1.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">

                                <h1 class="mb-2">Welcome To Suites</h1>
                                <h2 class="caption">Hotel &amp; Resort</h2>
                            </div>
                        </div>
                    </div>
                </div>  

                <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/hero_2.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Unique Experience</h1>
                                <h2 class="caption">Enjoy With Us</h2>
                            </div>
                        </div>
                    </div>
                </div> 

                <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/hero_3.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
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

            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-5 mx-auto text-center mb-6 section-heading">
                            <div><h2 class="mb-5">Search Customer Info</h2></div>
                            <div class="booking_form_container mybk p-3">
                                <form:form
                                    action="${pageContext.request.contextPath}/reception/option_processes"
                                    modelAttribute="searchCheck" cssClass="booking_form">
                                    <div
                                        class=" d-flex flex-lg-row flex-column align-items-start justify-content-start">
                                        <div style="font-size: 140%; width: 200px; font-family: arial;" >
                                            <input type="text" class=" bk" name="bookingCode" placeholder="Enter Booking Code"/>
                                        </div>
                                        <div class="ml-4">
                                            <button type="submit" class="booking_button">Check Information</button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>

                            <c:if test="${not empty message}">
                                <div class="p-5" style="font-size: 150%;"><h3  class="text-info">${message}</h3></div>
                                </c:if>
                        </div>
                    </div>
                </div>
            </div>

            < <div class="py-5 quick-contact-info">
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
