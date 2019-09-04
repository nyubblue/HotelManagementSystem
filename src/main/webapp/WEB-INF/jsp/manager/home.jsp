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
        <title>Manager HomePage</title>
        <jsp:include page="../include/header.jsp" />
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
                                                <li class="has-children">
                                                    <a href="<c:url value="/manager/standard" />">Rooms</a>
                                                    <ul class="dropdown arrow-top">
                                                        <li><a href="<c:url value="/manager/standard" />">List Room</a></li>
                                                        <li><a href="<c:url value="/manager/listCategory" />">List Category Room</a></li>
                                                    </ul>
                                                </li>
                                                <li class="has-children">
                                                    <a href="<c:url value="/manager/listService" />">Services</a>
                                                    <ul class="dropdown arrow-top">
                                                        <li><a href="<c:url value="/manager/listService" />">List Service</a></li>
                                                        <li><a href="<c:url value="/manager/form-add-service"/>">Add Service</a></li>
                                                    </ul>
                                                </li>
                                                <li class="has-children">
                                                    <a href="<c:url value="/manager/listPromotion" />">Promotion</a>
                                                    <ul class="dropdown arrow-top">
                                                        <li><a href="<c:url value="/manager/listPromotion" />">List Promotion</a></li>
                                                        <li><a href="<c:url value="/manager/form-add-promotion"/>">Add Promotion</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="<c:url value="/manager/list-booking" />">Manager Booking</a></li>
                                                <li><a href="<c:url value="/manager/list-customer" />">Profile</a></li>
                                                <li> <sec:authorize access="!isAuthenticated()">
                                                        <a href="<c:url value="/login" />">Login</a>
                                                    </sec:authorize>
                                                    <sec:authorize access="isAuthenticated()">
                                                        <a href="<c:url value="/logout" />">Logout</a>
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

            <div class="slide-one-item home-slider owl-carousel">
                <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_1.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Welcome Manager</h1>
                            </div>
                        </div>
                    </div>
                </div>  

                <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_2.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Welcome Manager</h1>
                            </div>
                        </div>
                    </div>
                </div> 

                <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_3.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Welcome Manager</h1>
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
