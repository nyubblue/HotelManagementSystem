<%-- 
    Document   : standardRoom
    Created on : Jul 21, 2019, 6:12:59 PM
    Author     : HP
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Room</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 style="color: #08c">List Room</h2>
                        </div>
                    </div>
                    <!--Success/fail-->
                    <c:if test="${messages!=null && messages!=''}">
                        <div class="row">
                            <div class="col-sm-12">
                                <c:if test="${status!=null && status=='success'}">
                                    <div class="alert alert-success">
                                        ${messages}
                                    </div>
                                </c:if>
                                <c:if test="${status!=null && status=='fail'}">
                                    <div class="alert alert-danger">
                                        ${messages}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <div class="row">
                        <!--search-->
                        <div class="col-sm-6" style="padding-bottom: 5px">
                            <form action="${pageContext.request.contextPath}/manager/search" method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" name="searchTxt" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <!--add-->
                        <div class="col-sm-6" style="text-align: right">
                            <button class="btn btn-info"
                                    onclick="location.href = '<c:url value="/manager/form-add-room"/>'">
                                Add Room</button>
                        </div>
                    </div>                  
                    <!--list rooms-->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <tr>
                                        <th>No.</th>
                                        <th>Category</th>
                                        <th>Room Name</th>
                                        <th>Create Date</th>
                                        <th>Price</th>
                                        <th>Status</th>
                                        <th colspan="2">Action</th>
                                        <th colspan="2">Update Status</th>
                                    </tr>
                                    <c:set var = "count"  value = "1"/>
                                    <c:forEach var="room" items="${room}">
                                        <tr>
                                            <td><c:out value = "${count}"/></td>
                                            <td>${room.roomCategory.name}</td>
                                            <td>${room.room_number}</td>
                                            <td><fmt:formatDate type="date" value="${room.createAT}" pattern="dd/MM/yyyy" /></td>
                                            <td>$${room.roomCategory.price}</td>
                                            <c:if test="${room.status == 'UnAvailable'}">
                                                <td style="color: red">${room.status}</td></c:if>
                                            <c:if test="${room.status == 'Available'}">
                                                <td style="color: blue">${room.status}</td></c:if>
                                                <!--action-->


                                                <!--Available/ Unavailable-->
                                                <td> <button  class="btn btn" style="color: green"
                                                              onclick="location.href = '<c:url value="update-form/${room.id}"/>'">
                                                    Update</button></td>
                                            <td> <button class="btn btn-info " style="color: whitesmoke; width: 100px" 
                                                         onclick="location.href = '<c:url value="detail/${room.id}"/>'">
                                                    Detail</button></td>
                                        <form:form action="${pageContext.request.contextPath}/manager/update-status-room/${room.id}" method="post" 
                                                   class="form-horizontal" >
                                            <td>
                                                <select name="status" class="form-control">
                                                    <option value="yes" selected>Available</option>
                                                    <option value="no" selected>UnAvailable</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-success  text-center" 
                                                        type="submit">Update</button>
                                            </td>
                                        </form:form>

                                        <c:set var = "count"  value = "${count+1}"/>
                                        </tr>
                                    </c:forEach>
                                    <!--if-no-record-->
                                    <c:if test="${room==null || fn:length(room)<=0}">
                                        <tr>
                                            <td style="color: red"
                                                colspan="7">No records</td>
                                        </tr>
                                    </c:if>
                                </table>
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
