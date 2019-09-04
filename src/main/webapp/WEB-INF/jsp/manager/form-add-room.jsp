<%-- 
    Document   : form-add-room
    Created on : Jul 21, 2019, 10:20:46 PM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Form Add Room</title>
        <jsp:include page="../include/header.jsp" />
        <style>
            .ui-error{
                color: red
            }
        </style>
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <c:if test="${action=='add_room'}">
                                <h2 style="color: #08c">Add Room</h2>
                            </c:if>
                            <c:if test="${action=='update-room'}">
                                <h2 style="color: #08c">Update Room</h2>
                            </c:if>
                        </div>
                    </div>
                    <!--message-->
                    <c:if test="${message!=null && message!=''}">
                        <div class="row">
                            <div class="col-sm-12">
                                <c:if test="${status!=null && status=='success'}">
                                    <div class="alert alert-success">
                                        ${message}
                                    </div>
                                </c:if>
                                <c:if test="${status!=null && status=='fail'}">
                                    <div class="alert alert-danger">
                                        ${message}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form action="${pageContext.request.contextPath}/manager/${action}" method="post" 
                                       modelAttribute="room" class="form-horizontal" >
                                <!--if update-->
                                <c:if test="${action=='update-room'}">
                                    <input name="id" value="${room.id}" hidden />
                                </c:if>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Room Category</label>
                                    <select name="roomCategory.id" class="form-control">
                                        <c:forEach items="${category}" var="c">
                                            <c:if test="${c.id==room.roomCategory.id}" >
                                                <option value="${c.id}" selected>${c.name}</option>
                                            </c:if>
                                            <c:if test="${c.id!=room.roomCategory.id}" >
                                                <option value="${c.id}">${c.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Room Number <span class="ui-error">(*)</span></label>
                                    <input name="room_number" class="form-control" value="${room.room_number}" required/>
                                    <form:errors path="room_number" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Room Status <span class="ui-error">(*)</span></label>
                                    <input name="status" class="form-control" value="${room.status}" required/>
                                    <form:errors path="status" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label  class="control-label col-sm-2">
                                        Create Date</label>
                                    <input type="date" name="createAT" value="${room.createAT}"class="form-control"/>
                                </div>
                                <div class="form-group" >
                                    <div  style="text-align: center">
                                        <c:if test="${action=='add_room'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Add Room</button></c:if>
                                        <c:if test="${action=='update-room'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Update Room</button></c:if>
                                        </div> 
                                    </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>