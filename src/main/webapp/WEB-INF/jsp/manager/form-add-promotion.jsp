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
        <title>Form Add Promotion</title>
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
                            <c:if test="${action=='add_promotion'}">
                                <h2  style="color: #08c">Add Promotion</h2>
                            </c:if>
                            <c:if test="${action=='update-promotion'}">
                                <h2 style="color: #08c">Update Promotion</h2>
                            </c:if>
                        </div>
                    </div>

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
                                       modelAttribute="promotion" class="form-horizontal" enctype="multipart/form-data">
                                <c:if test="${action=='update-promotion'}">
                                    <input name="id" value="${promotion.id}" hidden />
                                </c:if>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Name <span class="ui-error">(*)</span></label>
                                        <input name="name" class="form-control" value="${promotion.name}" required/>
                                    <form:errors path="name" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Description </label>
                                    <input name="description" class="form-control" value="${promotion.description}"/>
                                    <form:errors path="description" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        DisCount <span class="ui-error">(*)</span></label>
                                    <input name="discount" class="form-control" value="${promotion.discount}" required />
                                    <form:errors path="discount" cssClass="ui-error"/>
                                </div>
                                <div class="form-group">
                                    <label  class="control-label col-sm-2">
                                        Start Date<span class="ui-error">(*)</span></label>
                                    <input type="date" name="startDate" value="${promotion.startDate}"class="form-control" required/>
                                </div>
                                <div class="form-group">
                                    <label  class="control-label col-sm-2">
                                        End Date<span class="ui-error">(*)</span></label>
                                    <input type="date" name="endDate" value="${promotion.endDate}"class="form-control" required/>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Status </label>
                                    <input name="status" class="form-control" value="${promotion.status}"/>
                                    <form:errors path="status" cssClass="ui-error"/>
                                </div>

                                <div class="form-group" >
                                    <label class="control-label col-sm-2">
                                        Room Category<span class="ui-error">(*)</span></label>
                                        <c:forEach var="c" items="${category}">
                                            <input name = "roomCategorys" type = "checkbox" value = "${c.id}" checked/>${c.name}
                                    </c:forEach>
                                </div>

                                <div class="form-group" >
                                    <div  style="text-align: center">
                                        <c:if test="${action=='add_promotion'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Add Promotion</button></c:if>
                                        <c:if test="${action=='update-promotion'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Update Promotion</button></c:if>
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