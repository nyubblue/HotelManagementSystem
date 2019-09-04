<%-- 
    Document   : menu
    Created on : Jun 24, 2019, 7:18:41 PM
    Author     : AnhLe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <p><a href="<c:url value="/home" />">Home</a></p>
        <sec:authorize access="isAuthenticated()">
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <p><a href="<c:url value="/admin/home" />">Admin Home</a></p>
            </sec:authorize>
            <sec:authorize access="hasRole('ROLE_USER')">
                <p><a href="<c:url value="/user/home" />">User Home</a></p>
            </sec:authorize>
            <p><a href="<c:url value="/logout" />">Logout</a></p>
        </sec:authorize>
        <sec:authorize access="!isAuthenticated()">
            <p><a href="<c:url value="/login" />">Login</a></p>
        </sec:authorize>
    </body>
</html>
