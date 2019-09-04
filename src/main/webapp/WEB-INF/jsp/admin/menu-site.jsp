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

                                            <li class="has-children">
                                                <a href="<c:url value="/admin/listAccount" />">Account</a>
                                                <ul class="dropdown arrow-top">
                                                    <li><a href="<c:url value="/admin/listAccount" />">List Account</a></li>
                                                    <li><a href="<c:url value="/admin/form-add-account"/>">Add Account</a></li>
                                                </ul>
                                            </li>
                                            <li >
                                                <a href="<c:url value="/admin/profile" />">Profile</a>
                                            </li>

                                            <sec:authorize access="isAuthenticated()">
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
