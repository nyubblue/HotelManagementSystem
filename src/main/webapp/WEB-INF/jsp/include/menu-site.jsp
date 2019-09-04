<%-- 
    Document   : menu-site
    Created on : Jul 29, 2019, 10:58:49 PM
    Author     : HP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="site-navbar-wrap js-clone-nav bg-light scrolled">
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
                                                    <li><a href="<c:url value="/manager/listService" />">List Services</a></li>
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
                                            <li><a href="<c:url value="/manager/profile" />">Profile</a></li>
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

    </body>
</html>
