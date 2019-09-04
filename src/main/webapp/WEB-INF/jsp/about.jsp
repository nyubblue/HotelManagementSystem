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
        <title>About Us</title>
        <jsp:include page="include/header.jsp"></jsp:include>
        <jsp:include page="include_b/header-css.jsp"></jsp:include>
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
            <div class="site-navbar-wrap js-site-navbar scrolled">
                <div class="container">
                    <div class="site-navbar bg-image">
                        <div class="py-1">
                            <div class="row align-items-center">
                                <div class="col-12">
                                    <nav class="site-navigation text-right" role="navigation">
                                        <div class="container">
                                            <div class="d-inline-block d-lg-none  ml-md-0 mr-auto py-3"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu h3"></span></a></div>
                                            <ul class="site-menu js-clone-nav d-none d-lg-block">
                                                <li class="active">
                                                    <a href="<c:url value="/home" />">Home</a>
                                                </li>
                                                <sec:authorize access="isAuthenticated()">
                                                    <li>  <a href="<c:url value="/user/home" />">Profile</a></li>  
                                                    <li>  <a href="<c:url value="/logout" />">Logout</a></li>  
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                    <li><a href="<c:url value="/about_us" />">About Us</a></li>
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
                                <h1 class="mb-2">Unique Experience</h1>
                                <h2 class="caption">Enjoy With Us</h2>
                            </div>
                        </div>
                    </div>
                </div> 

                <div class="site-blocks-cover overlay" style="background-image: url(<s:url value="/resources/images/hero_3.jpg"/>);" data-aos="fade" data-stellar-background-ratio="0.5">
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

            <div class="site-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-6 mb-5 mb-md-0">

                            <div class="img-border">
                                <a href="https://vimeo.com/28959265" class="popup-vimeo image-play">
                                    <span class="icon-wrap">
                                        <span class="icon icon-play"></span>
                                    </span>
                                    <img src="images/img_2.jpg" alt="" class="img-fluid">
                                </a>
                            </div>

                            <img src="<s:url value="/resources/images/img_1.jpg"/>" alt="Image" class="img-fluid image-absolute">

                        </div>
                        <div class="col-md-5 ml-auto">


                            <div class="section-heading text-left">
                                <h2 class="mb-5">About Us</h2>
                            </div>
                            <p class="mb-4">Being the 18th member of "The largest hotel chain in Vietnam", the 4-star B&T hotel is located on the East bank of the romantic Han River and faces one of the most beautiful beaches in central of Vietnam</p>
                            <p><a href="https://vimeo.com/28959265" class="popup-vimeo text-uppercase">Watch Video <span class="icon-arrow-right small"></span></a></p>
                        </div>
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

            <jsp:include page="include/footer.jsp" />
        </div>
        <jsp:include page="include/footer-script.jsp"/>
        <jsp:include page="include_b/footer-script.jsp"/>
    </body>
</html>
