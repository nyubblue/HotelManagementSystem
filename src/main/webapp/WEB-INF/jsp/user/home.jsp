<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <jsp:include page="../include/header.jsp"></jsp:include>
        <jsp:include page="../include_b/header-css.jsp"></jsp:include>
        <s:url var="url_jqlib" value="/resources_b/js/jquery-3.3.1.min.js" />
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
                                                        <a href="<c:url value="/user/home" />">Home</a>
                                                    </li>
                                                </sec:authorize>
                                                <sec:authorize access="!isAuthenticated()">
                                                    <li class="active">
                                                        <a href="<c:url value="/home" />">Home</a>
                                                    </li>
                                                </sec:authorize>
                                                <c:if test="${not empty booking}">
                                                    <li><a href="<c:url value="/cancelBooking" />">Cancel Booking</a></li>
                                                    </c:if>
                                                <li>  <a href="<c:url value="/category" />">Room Type</a></li>
                                                <li><a href="<c:url value="/about_us" />">About Us</a></li>
                                                    <sec:authorize access="isAuthenticated()">
                                                    <li>  <a href="<c:url value="/user/profile" />">Profile</a></li>  
                                                    <li>  <a href="<c:url value="/user/view_history" />">History</a></li>  
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
                        <div class="col-md-7 mx-auto text-center mb-6 section-heading">
                            <div class="booking_form_container mybk p-3">
                                <form:form
                                    action="${pageContext.request.contextPath}/searchBooking"
                                    modelAttribute="search_domain" cssClass="booking_form">
                                    <div
                                        class=" d-flex flex-lg-row flex-column align-items-start justify-content-start">
                                        <c:if test="${booking == null}">
                                            <div>
                                                <input name="checkIn" type="text" id="from"
                                                       class="buttonbk booking_in"
                                                       placeholder="Check in">
                                            </div>
                                            <div>
                                                <input name="checkOut" type="text" id="to"
                                                       class=" buttonbk booking_out"
                                                       placeholder="Check out">
                                            </div>
                                        </c:if>
                                        <div >
                                            <select name="roomCategoryId"
                                                    class="custom-select buttonbk">
                                                <option selected value="0">Room Type</option>
                                                <c:forEach var="category" items="${categoryList}" >
                                                    <option value="${category.id}">${category.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="ml-4">
                                            <button type="submit" class="booking_button trans_200">Book
                                                Now</button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>

                            <h2 class="mb-5">Our Rooms</h2>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="category" items="${categories}" varStatus="indexCategory">
                            <div class="col-md-6 col-lg-4 mb-5">
                                <div class="hotel-room text-center">
                                    <a href="<c:url value="/clickCategory/${category.id}" />" class="d-block mb-0 thumbnail">
                                        <c:forEach var="image" items="${category.imageEntities}" varStatus="status">
                                            <c:if test="${status.count ==1}">
                                                <div class="carousel-item active">
                                                    <img src="../resources/images/${image.name}" alt="Image" class="img-fluid">
                                                </div>
                                            </c:if>
                                            <c:if test="${status.count !=1}">
                                                <div class="carousel-item">
                                                    <img src="../resources/images/${image.name}" alt="Image" class="img-fluid">
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </a>
                                    <div class="hotel-room-body">
                                        <h3 class="heading mb-0"><a href="#">${category.name}</a></h3>
                                        <strong class="price">${category.price} / per night</strong>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!--  Services-->
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 class="mb-5">Our Hot Services</h2>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="service" items="${services}">
                            <div class="col-md-6 col-lg-4 mb-5">
                                <div class="hotel-room text-center">
                                    <a href="#" class="d-block mb-4 thumbnail">
                                        <c:if test="${not empty service.imageEntities}"><img src="../resources/images/${service.imageEntities[0].name}" alt="Image" class="img-fluid">
                                        </c:if></a>
                                    <div class="p-4">
                                        <h3 class="heading mb-3"><a href="#">${service.name}</a></h3>
                                        <p>${service.description}</p>
                                        <p><a href="#" class="text-primary">Read More <span class="icon-arrow-right small"></span></a></p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>


                    </div>
                </div>
            </div>


            <div class="site-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 class="mb-5">Hotel Features</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-pool display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Swimming Pool</h2>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-desk display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Hotel Teller</h2>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-exit display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Fire Exit</h2>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-parking display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Car Parking</h2>
                            </div>
                        </div>

                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-hair-dryer display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Hair Dryer</h2>
                            </div>
                        </div>

                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-minibar display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Minibar</h2>
                            </div>
                        </div>

                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-drink display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Drinks</h2>
                            </div>
                        </div>

                        <div class="col-sm-6 col-md-4 col-lg-3">
                            <div class="text-center p-4 item">
                                <span class="flaticon-cab display-3 mb-3 d-block text-primary"></span>
                                <h2 class="h5">Car Airport</h2>
                            </div>
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
