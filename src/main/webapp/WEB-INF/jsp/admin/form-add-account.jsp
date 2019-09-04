<%-- 
    Document   : home
    Created on : Jul 16, 2019, 8:06:44 PM
    Author     : AnhLe
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Form Add Account</title>
        <jsp:include page="../include/header.jsp" />
        <style>
            .ui-error{
                color: red
            }
        </style>
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-2 section-heading">
                            <c:if test="${action=='add_account'}">
                                <h2 style="color: #08c">Add Account</h2>
                            </c:if>
                            <c:if test="${action=='update-account'}">
                                <h2 style="color: #08c">Update Account</h2>
                            </c:if>
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
                        <div class="col-sm-12">
                            <form:form action="${pageContext.request.contextPath}/admin/${action}" method="post" 
                                       modelAttribute="account" class="form-horizontal">
                                <c:if test="${action=='update-account'}">
                                    <input name="id" value="${account.id}" hidden />
                                </c:if>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Full Name <span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input name="fullName" class="form-control" value="${account.fullName}" required/>
                                        <form:errors path="fullName" cssClass="ui-error"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Email <span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input name="email" type="email" class="form-control" value="${account.email}"/>
                                        <form:errors path="email" cssClass="ui-error"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Password <span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input name="password" type="password" class="form-control" value="${account.password}" required/>
                                        <form:errors path="password" cssClass="ui-error"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Address <span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input name="address" class="form-control" value="${account.address}"/>
                                        <form:errors path="address" cssClass="ui-error"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label  class="control-label col-sm-2">
                                        Gender</label>
                                    <div class="col-sm-8">
                                        <c:forEach items="${genders}" var="gender">
                                            <c:if test="${gender==account.gender}" >
                                                <label class="radio-inline">
                                                    <input type="radio" name="gender" checked value="${gender}"/>
                                                    ${gender}
                                                </label>
                                            </c:if>
                                            <c:if test="${gender!=account.gender}" >
                                                <label class="radio-inline">
                                                    <input type="radio" name="gender" value="${gender}"/>
                                                    ${gender}
                                                </label>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label  class="control-label col-sm-2">
                                        BirthDate</label>
                                    <div class="col-sm-8">
                                        <input type="date" name="birhDate" value="${account.birhDate}"class="form-control"/>
                                    </div>
                                </div>
                                <c:if test="${action == 'update-account'}">
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Account Status <span class="ui-error">(*)</span></label>
                                        <div class="col-sm-8">
                                            <input name="status" class="form-control" value="${account.status}"/>
                                            <form:errors path="status" cssClass="ui-error"/>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${action == 'add_account'}">
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Account Status <span class="ui-error">(*)</span></label>
                                        <div class="col-sm-8">
                                            <input name="status" class="form-control" value="Block" readonly="true"/>
                                            <form:errors path="status" cssClass="ui-error"/>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">Role </label>
                                    <div class="col-sm-8">
                                        <select name="accountRoles" class="form-control">
                                            <c:forEach items="${roles}" var="role">
                                                <option value="${role.id}"  >${role.role}</option>
                                            </c:forEach>
                                        </select></div>
                                </div>

                                <c:if test="${action=='update-account'}">
                                    <input name="id" value="${account.id}" hidden />
                                </c:if>

                                <div class="form-group" >
                                    <div class="col-sm-8" style="text-align: center">
                                        <c:if test="${action=='add_account'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Add Account</button></c:if>
                                        <c:if test="${action=='update-account'}">
                                            <button class="btn btn-primary" 
                                                    type="submit">Update Account</button></c:if>
                                        </div> 
                                    </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>
