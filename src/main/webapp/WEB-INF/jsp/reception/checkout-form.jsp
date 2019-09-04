<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<c:url value="/webjars/bootstrap/4.1.2/css/bootstrap.min.css"/>"  type="text/css" rel="stylesheet"/>
              <title>Confirm Customer Info</title>
        <style>
            body{
                font-family: Arial;
                font-size: 120%;
            }
            .ui-error{
                color: red;
            }
            .error {
                color: red;
                font-weight: bold;
                font-style: italic;
            }
            .fieldset {
                border: 1px solid #ccc;
                padding: 10px;
            }

        </style>
    </head>
    <body>
        <div class="bg-dark">
            <div class="container  bg-light">
                <fieldset class=" border m-2 fieldset">
                    <legend  class="w-auto"><h2>Confirm Customer Info</h2></legend>

                    <div style="margin: auto 0;" class="col-sm-12" >
                        <form:form action="${pageContext.request.contextPath}/reception/processCheckOut" method="post" 
                                   modelAttribute="customerInfo" class="form-horizontal">
                            <div class="form-group">
                                <label class="control-label col-sm-2">
                                    Full Name<span class="ui-error">(*)</span></label>
                                <div class="col-sm-12">
                                    <input name="fullName" class="form-control" value="${customerInfo.fullName}"/>
                                    <form:errors path="fullName" cssClass="ui-error"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">
                                    Email <span class="ui-error">(*)</span></label>
                                <div class="col-sm-12">
                                    <input type="text" name="email" class="form-control" value="${customerInfo.email}"/>
                                    <form:errors path="email" cssClass="ui-error"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label name="birthDate" class="control-label col-sm-2">
                                    Birth Date<span class="ui-error">(*)</span></label>
                                <div class="col-sm-12">
                                    <input type="date" name="birthDate" class="form-control" value="${customerInfo.birthDate}"/>
                                    <form:errors path="birthDate" cssClass="ui-error"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">
                                    ID Card<span class="ui-error">(*)</span></label>
                                <div class="col-sm-12">
                                    <input name="idCard" class="form-control" value="${customerInfo.idCard}"/>
                                    <form:errors path="idCard" cssClass="ui-error"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">
                                    Phone<span class="ui-error">(*)</span></label>
                                <div class="col-sm-12">
                                    <input name="phone" class="form-control" value="${customerInfo.phone}"/>
                                    <form:errors path="phone" cssClass="ui-error"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">
                                    Address</label>
                                <div class="col-sm-12">
                                    <textarea name="address" class="form-control">${customerInfo.address}</textarea>
                                </div>
                            </div> 

                            <div class="form-group">
                                <label path="gender" class="control-label col-sm-2">
                                    Gender</label>
                                <div class="col-sm-12">
                                    <c:forEach items="${genders}" var="gender">
                                        <c:if test="${customerInfo.gender == gender}">
                                            <label class="radio-inline mr-2">
                                                <input type="radio" checked name="gender" value="${gender}"/>
                                                ${gender}
                                            </label>
                                        </c:if>
                                        <c:if test="${customerInfo.gender != gender}">
                                            <label class="radio-inline mr-2">
                                                <input type="radio" name="gender" value="${gender}"/>
                                                ${gender}
                                            </label>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <input type="number" name="accountEntity.id" value="${bookingId}" hidden="true"/>

                            <div class="form-group" style="text-align: center">
                                <button class="btn btn-primary" 
                                        type="submit">Finsh CheckOut</button>
                            </div>
                        </form:form>
                    </div>

                </fieldset>
            </div>
        </div>
    </body>
</html>
