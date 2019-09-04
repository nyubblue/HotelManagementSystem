<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                                        <li>  <a href="<c:url value="/user/home" />">Profile</a></li>  
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
