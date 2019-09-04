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
        <title>Form Add Room Category</title>
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
                            <c:if test="${action=='add_category'}">
                                <h2 style="color: #08c">Add Category</h2>
                            </c:if>
                            <c:if test="${action=='update-category'}">
                                <h2>Update Category</h2>
                            </c:if>
                        </div>
                    </div>
                    <!--show message-->
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
                    <!--form-->
                    <div class="row">
                        <c:forEach var="images" items="${category.imageEntities}">
                            <div class="row">
                                <div class="col-md-6 col-lg-3 mb-5">
                                    <div class="hotel-room text-center">
                                        <img src="<c:url value="/resources/images/${images.name}"/>" 
                                             alt="${images.name}" title="${images.name}" width="220" height="180">
                                        <button class="btn btn-warning mb-1" type="button"
                                                onclick="location.href = '<c:url value="/manager/removeImg/${category.id}/${images.id}"/>'">
                                            Remove Image</button></div>
                                </div>
                            </div>
                        </c:forEach> 
                        <div class="col-sm-12">
                            <form:form action="${pageContext.request.contextPath}/manager/${action}" method="post" 
                                       modelAttribute="category" class="form-horizontal" enctype="multipart/form-data">
                                <c:if test="${action=='update-category'}">
                                    <input name="id" value="${category.id}" hidden />
                                </c:if>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">Category Name<span class="ui-error">(*)</span></label>
                                    <input name="name" class="form-control" value="${category.name}" required />
                                    <form:errors path="name" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Price <span class="ui-error">(*)</span></label>
                                    <input name="price" class="form-control" value="${category.price}" required/>
                                    <form:errors path="price" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Size Room <span class="ui-error">(*)</span></label>
                                    <input name="sizeRoom" class="form-control" value="${category.sizeRoom}" required/>
                                    <form:errors path="sizeRoom" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Number Of Bed </label>
                                    <input name="number_of_bed" class="form-control" value="${category.number_of_bed}"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Description </label>
                                    <input name="description" class="form-control" value="${category.description}"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Convenience </label>
                                    <input name="convenience" class="form-control" value="${category.convenience}"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Status <span class="ui-error">(*)</span></label>
                                    <input name="status" class="form-control" value="${category.status}" required/>
                                    <form:errors path="status" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">Upload Image</label>
                                    <div class="row"> 
                                        <div class="col-sm-8 mb-2">
                                            <input type="file" name="file"><br /> 
                                        </div>
                                        <div class="col-sm-8">
                                            <input type="file" name="file"><br /> 
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" >
                                    <div  style="text-align: center">
                                        <c:if test="${action=='add_category'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Add Category</button></c:if>
                                        <c:if test="${action=='update-category'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Update Category</button></c:if>
                                        </div> 
                                    </div>
                                </div>
                        </form:form>
                        <!--show image if update-->

                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>