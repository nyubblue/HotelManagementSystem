<%-- 
    Document   : home
    Created on : Jul 16, 2019, 8:06:44 PM
    Author     : AnhLe
--%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <jsp:include page="include/header.jsp"></jsp:include>
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
                                                    <li class="active">
                                                        <a href="<c:url value="home" />">Home</a>
                                                </li>

                                                <sec:authorize access="isAuthenticated()">
                                                    <li>  <a href="<c:url value="/manager/home" />">Home</a></li>  
                                                    <li>  <a href="<c:url value="/logout" />">Logout</a></li>  
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                    <li><a href="<c:url value="/login" />">Login</a></li>
                                                    <li><a href="<c:url value="/register" />">Register</a></li>  
                                                    </sec:authorize>
                                                <li>
                                                    <form class="form-inline">
                                                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                                    </form>
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

            <div class="slide-one-item home-slider owl-carousel">
                <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_1.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">

                                <h1 class="mb-2">Welcome To Suites</h1>
                                <h2 class="caption">Hotel &amp; Resort</h2>
                            </div>
                        </div>
                    </div>
                </div>  

                <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_2.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Unique Experience</h1>
                                <h2 class="caption">Enjoy With Us</h2>
                            </div>
                        </div>
                    </div>
                </div> 

                <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_3.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
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
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 class="mb-5">Our Rooms</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="hotel-room text-center">
                                <a href="#" class="d-block mb-0 thumbnail"><img src="resources/images/img_1.jpg" alt="Image" class="img-fluid"></a>
                                <div class="hotel-room-body">
                                    <h3 class="heading mb-0"><a href="#">Standard Room</a></h3>
                                    <strong class="price">$350.00 / per night</strong>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="hotel-room text-center">
                                <a href="#" class="d-block mb-0 thumbnail"><img src="resources/images/img_2.jpg" alt="Image" class="img-fluid"></a>
                                <div class="hotel-room-body">
                                    <h3 class="heading mb-0"><a href="#">Family Room</a></h3>
                                    <strong class="price">$400.00 / per night</strong>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="hotel-room text-center">
                                <a href="#" class="d-block mb-0 thumbnail"><img src="resources/images/img_3.jpg" alt="Image" class="img-fluid"></a>
                                <div class="hotel-room-body">
                                    <h3 class="heading mb-0"><a href="#">Single Room</a></h3>
                                    <strong class="price">$255.00 / per night</strong>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="hotel-room text-center">
                                <a href="#" class="d-block mb-0 thumbnail"><img src="resources/images/img_1.jpg" alt="Image" class="img-fluid"></a>
                                <div class="hotel-room-body">
                                    <h3 class="heading mb-0"><a href="#">Deluxe Room</a></h3>
                                    <strong class="price">$150.00 / per night</strong>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="hotel-room text-center">
                                <a href="#" class="d-block mb-0 thumbnail"><img src="resources/images/img_2.jpg" alt="Image" class="img-fluid"></a>
                                <div class="hotel-room-body">
                                    <h3 class="heading mb-0"><a href="#">Luxury Room</a></h3>
                                    <strong class="price">$200.00 / per night</strong>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4 mb-5">
                            <div class="hotel-room text-center">
                                <a href="#" class="d-block mb-0 thumbnail"><img src="resources/images/img_3.jpg" alt="Image" class="img-fluid"></a>
                                <div class="hotel-room-body">
                                    <h3 class="heading mb-0"><a href="#">Single Room</a></h3>
                                    <strong class="price">$155.00 / per night</strong>
                                </div>
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
                                <a href="https://www.youtube.com/watch?v=knW7-x7Y7RE" class="popup-vimeo image-play">
                                    <span class="icon-wrap">
                                        <span class="icon icon-play"></span>
                                    </span>
                                    <img src="resources/images/img_2.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <img src="resources/images/img_1.jpg" alt="Image" class="img-fluid image-absolute">
                        </div>
                        <div class="col-md-5 ml-auto">
                            <div class="section-heading text-left">
                                <h2 class="mb-5">About Us</h2>
                            </div>
                            <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eaque, nisi Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odit nobis magni eaque velit eum, id rem eveniet dolor possimus voluptas..</p>
                            <p><a href="https://www.youtube.com/watch?v=knW7-x7Y7RE" class="popup-vimeo text-uppercase">Watch Video <span class="icon-arrow-right small"></span></a></p>
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

            <div class="py-5 upcoming-events" style="background-image: url('images/hero_1.jpg'); background-attachment: fixed;">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h2 class="text-white">Summer Promo 50% Off</h2>
                            <a href="#" class="text-white btn btn-outline-warning rounded-0 text-uppercase">Avail Now</a>
                        </div>
                        <div class="col-md-6">
                            <span class="caption">The Promo will start in</span>
                            <div id="date-countdown"></div>    
                        </div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 class="mb-5">Our Gallery</h2>
                        </div>
                    </div>
                    <div class="row no-gutters">
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_1.jpg" class="image-popup img-opacity"><img src="images/img_1.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_2.jpg" class="image-popup img-opacity"><img src="images/img_2.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_3.jpg" class="image-popup img-opacity"><img src="images/img_3.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_4.jpg" class="image-popup img-opacity"><img src="images/img_4.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_4.jpg" class="image-popup img-opacity"><img src="images/img_4.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_5.jpg" class="image-popup img-opacity"><img src="images/img_5.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_6.jpg" class="image-popup img-opacity"><img src="images/img_6.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <a href="images/img_7.jpg" class="image-popup img-opacity"><img src="images/img_7.jpg" alt="Image" class="img-fluid"></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="site-section block-15">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2>Upcoming Events</h2>
                        </div>
                    </div>

                    <div class="nonloop-block-15 owl-carousel">
                        <div class="media-with-text p-md-5">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_1.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_2.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_3.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_1.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_2.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_3.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_1.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_2.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>

                        <div class="media-with-text p-md-4">
                            <div class="img-border-sm mb-4">
                                <a href="#" class="popup-vimeo image-play">
                                    <img src="images/img_3.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                            <h2 class="heading mb-0"><a href="#">Lorem Ipsum Dolor Sit Amet</a></h2>
                            <span class="mb-3 d-block post-date">Dec 20th, 2018 &bullet; By <a href="#">Admin</a></span>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio dolores culpa qui aliquam placeat nobis veritatis tempora natus rerum obcaecati.</p>
                        </div>
                    </div>
                </div>
            </div>


            <div class="site-section block-14 bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2>What People Say</h2>
                        </div>
                    </div>

                    <div class="nonloop-block-14 owl-carousel">
                        <div class="p-4">
                            <div class="d-flex block-testimony">
                                <div class="person mr-3">
                                    <img src="images/person_1.jpg" alt="Image" class="img-fluid rounded">
                                </div>
                                <div>
                                    <h2 class="h5">Katie Johnson</h2>
                                    <blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias accusantium qui optio, possimus necessitatibus voluptate aliquam velit nostrum tempora ipsam!&rdquo;</blockquote>
                                </div>
                            </div>
                        </div>

                        <div class="p-4">
                            <div class="d-flex block-testimony">
                                <div class="person mr-3">
                                    <img src="images/person_2.jpg" alt="Image" class="img-fluid rounded">
                                </div>
                                <div>
                                    <h2 class="h5">Jane Mars</h2>
                                    <blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias accusantium qui optio, possimus necessitatibus voluptate aliquam velit nostrum tempora ipsam!&rdquo;</blockquote>
                                </div>
                            </div>
                        </div>

                        <div class="p-4">
                            <div class="d-flex block-testimony">
                                <div class="person mr-3">
                                    <img src="images/person_3.jpg" alt="Image" class="img-fluid rounded">
                                </div>
                                <div>
                                    <h2 class="h5">Shane Holmes</h2>
                                    <blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias accusantium qui optio, possimus necessitatibus voluptate aliquam velit nostrum tempora ipsam!&rdquo;</blockquote>
                                </div>
                            </div>
                        </div>

                        <div class="p-4">
                            <div class="d-flex block-testimony">
                                <div class="person mr-3">
                                    <img src="images/person_4.jpg" alt="Image" class="img-fluid rounded">
                                </div>
                                <div>
                                    <h2 class="h5">Mark Johnson</h2>
                                    <blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias accusantium qui optio, possimus necessitatibus voluptate aliquam velit nostrum tempora ipsam!&rdquo;</blockquote>
                                </div>
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
    </body>
</html>
