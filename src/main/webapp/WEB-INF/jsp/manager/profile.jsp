<%-- 
    Document   : home
    Created on : Jul 16, 2019, 8:06:44 PM
    Author     : HP
--%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Account</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container  bg-light">
                    <fieldset class=" border m-2 fieldset">
                        <legend  class="w-auto"><h2 class="text-success">Profile</h2></legend>
                        <div class="row">
                            <div class="col-sm-12">
                                <form:form action="${pageContext.request.contextPath}/manager/profile" method="post" 
                                           modelAttribute="account" class="form-horizontal">
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Full Name</label>
                                        <div class="col-sm-8">
                                            <input name="fullName" value="${account.fullName}" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Email Address </label>
                                        <div class="col-sm-8">
                                            <input name="email" type="email" class="form-control" value="${account.email}" readonly/>
                                            <form:errors path="status" cssClass="ui-error"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Password</label>
                                        <div class="col-sm-8">
                                            <input name="password" type="password" class="form-control" value="${account.password}" />
                                        </div>
                                    </div>
                                    <fmt:formatDate value="${account.birhDate}" type="date" var="birth" pattern = "yyyy-MM-dd" />
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Birth Date</label>
                                        <div class="col-sm-8">
                                            <input type="date" name="birhDate" value="${birth}" class="form-control " style="border-radius: 10px; width:50%;" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Address</label>
                                        <div class="col-sm-8">
                                            <textarea name="address" rows="2"  class="form-control">${account.address}</textarea>
                                        </div>
                                    </div> 

                                    <div class="form-group">
                                        <label path="gender" class="control-label col-sm-2">
                                            Gender</label>
                                        <div class="col-sm-8">
                                            <c:forEach items="${genders}" var="gender">
                                                <c:if test="${account.gender == gender}">
                                                    <label class="radio-inline mr-2">
                                                        <input type="radio" checked name="gender" value="${gender}"/>
                                                        ${gender}
                                                    </label>
                                                </c:if>
                                                <c:if test="${account.gender != gender}">
                                                    <label class="radio-inline mr-2">
                                                        <input type="radio" name="gender" value="${gender}"/>
                                                        ${gender}
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <input type="number" name="id" value="${account.id}" hidden="true" />
                                    <div class="form-group" style="text-align: center">
                                        <button class="btn btn-primary" 
                                                type="submit">Update</button>
                                    </div>
                                    <c:if test="${not empty message}">
                                        <h3 class="text-center" style="color: blue;" >${message}</h3>
                                    </c:if>
                                </form:form>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>
