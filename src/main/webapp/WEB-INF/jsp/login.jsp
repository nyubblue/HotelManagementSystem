<%-- 
    Document   : home
    Created on : Jul 16, 2019, 8:06:44 PM
    Author     : HP
--%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <jsp:include page="include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <div class="site-mobile-menu">
                <div class="site-mobile-menu-header">
                    <div class="site-mobile-menu-close mt-3">
                        <span class="icon-close2 js-menu-toggle"></span>
                    </div>
                </div>
                <div class="site-mobile-menu-body"></div>
            </div> <!-- .site-mobile-menu -->
            <div class="site-navbar-wrap js-site-navbar bg-white">
                <div class="container">
                    <div class="site-navbar bg-light">
                        <div class="py-1">
                            <div class="row align-items-center">
                                <div class="col-10">
                                    <nav class="site-navigation text-right" role="navigation">
                                        <div class="container">
                                            <div class="d-inline-block d-lg-none  ml-md-0 mr-auto py-3"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu h3"></span></a></div>
                                            <ul class="site-menu js-clone-nav d-none d-lg-block">
                                                <li class="active">
                                                    <a href="<c:url value="home" />">Home</a>
                                                </li>
                                                <li> 
                                                    <sec:authorize access="isAuthenticated()">
                                                        <a href="<c:url value="/logout" />">Logout</a>
                                                    </sec:authorize>
                                                </li>  
                                                <sec:authorize access="!isAuthenticated()">
                                                    <li><a href="<c:url value="/login" />">Login</a></li>
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

            <div class="site-blocks-cover overlay" style="background-image: url(resources/images/hero_1.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                <div class="container">
                    <div class="row align-items-center justify-content-center">
                        <div class="col-md-6 text-left" data-aos="fade" style="color: #449fdb">
                            <form action="<c:url value="j_spring_security_check"/>" method="post" class="p-5 bg-white">
                                <div class="form-group" style="text-align: center">
                                    <h5 style="color: red">${message}</h5>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        User Name: </label>

                                    <input name="username" class="form-control" placeholder="Enter user name" />
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        Password: </label>
                                    <input name="password" type="password" class="form-control" placeholder="Enter password" />

                                </div>
                                <div class="form-group" style="text-align: center">
                                    <button class="btn btn-primary" 
                                            type="submit">Login</button>
                                </div>
                                <div class="form-group" style="text-align: center">
                                    <a href="<c:url value="/forget-password" />">Forgot PassWord</a>
                                </div>

                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </form>

                        </div>
                    </div>
                </div>
            </div>   
            <jsp:include page="include/footer.jsp"/>                            
        </div>
        <jsp:include page="include/footer-script.jsp"/>
    </body>
</html>

