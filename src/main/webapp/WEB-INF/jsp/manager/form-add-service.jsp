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
        <title>Form Add Service</title>
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
                            <c:if test="${action=='add_service'}">
                                <h2 style="color: #08c">Add Service</h2>
                            </c:if>
                            <c:if test="${action=='update-service'}">
                                <h2 style="color: #08c">Update Service</h2>
                            </c:if>
                        </div>
                    </div>
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
                        <c:forEach var="images" items="${service.imageEntities}">
                            <div class="row">
                                <div class="col-md-6 col-lg-3 mb-5">
                                    <div class="hotel-room text-center">
                                        <img src="<c:url value="/resources/images/${images.name}"/>" 
                                             alt="${images.name}" title="${images.name}" width="200" height="150">
                                        <button class="btn btn-warning small mb-1" type="button"
                                                onclick="location.href = '<c:url value="/manager/removeImgService/${service.id}/${images.id}"/>'">
                                            Remove Image</button></div>
                                </div>
                            </div>
                        </c:forEach> 
                        <div class="col-sm-12">
                            <form:form action="${pageContext.request.contextPath}/manager/${action}" 
                                       method="post" modelAttribute="service" enctype="multipart/form-data">
                                <c:if test="${action=='update-service'}">
                                    <input name="id" value="${service.id}" hidden />
                                </c:if>
                                <div class="form-group">
                                    <label class="control-label">
                                        Name<span class="ui-error">(*)</span></label>
                                    <input name="name" class="form-control" value="${service.name}" required />
                                    <form:errors path="name" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        Price <span class="ui-error">(*)</span></label>
                                    <input name="price" class="form-control" value="${service.price}" required />
                                    <form:errors path="price" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        Description</label>
                                    <input name="description" class="form-control" value="${service.description}" />
                                    <form:errors path="description" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        Status </label>
                                    <input name="status" class="form-control" value="${service.status}" />
                                    <form:errors path="status" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Upload Image</label>
                                    <div class="row"> 
                                        <div class="col-sm-8 mb-2" >
                                            <input type="file" name="file"><br /> 
                                        </div>
                                        <div class="col-sm-8">
                                            <input type="file" name="file"><br /> 
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12" style="text-align: center">
                                        <c:if test="${action=='add_service'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Add Service</button></c:if>
                                        <c:if test="${action=='update-service'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Update Service</button></c:if>
                                        </div> 
                                    </div>
                            </form:form>
                            <!--show image if update-->

                        </div>

                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />

        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>