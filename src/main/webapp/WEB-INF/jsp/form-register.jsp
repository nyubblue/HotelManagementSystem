<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<c:url value="webjars/bootstrap/4.1.2/css/bootstrap.min.css"/>"  type="text/css" rel="stylesheet"/>
        <title>Register</title>
        <style>
            .ui-error{
                color: red;
            }
            .fieldset {
                border: 1px solid #ccc;
                padding: 10px;
            }

        </style>
    </head>
    <body>
        <div class="bg-info">
            <div class="container  bg-light">
                <fieldset class=" border m-2 fieldset">
                    <legend  class="w-auto"><h2>Register</h2></legend>
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form action="${pageContext.request.contextPath}/register_user" method="post" 
                                       modelAttribute="account" class="form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Full Name<span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input name="fullName" class="form-control"/>
                                        <form:errors path="fullName" cssClass="ui-error"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Password<span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input name="password" type ="password" class="form-control"/>
                                        <form:errors path="password" cssClass="ui-error"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Email <span class="ui-error">(*)</span></label>
                                    <div class="col-sm-8">
                                        <input type="text" name="email" class="form-control"/>
                                        <form:errors path="email" cssClass="ui-error"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label name="birthDate" class="control-label col-sm-2">
                                        Birth Date</label>
                                    <div class="col-sm-8">
                                        <input type="date" name="birhDate" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">
                                        Address</label>
                                    <div class="col-sm-8">
                                        <textarea name="address" class="form-control"></textarea>
                                    </div>
                                </div> 

                                <div class="form-group">
                                    <label path="gender" class="control-label col-sm-2">
                                        Gender</label>
                                    <div class="col-sm-8">
                                        <c:forEach items="${genders}" var="gender">
                                            <label class="radio-inline mr-2">
                                                <input type="radio" name="gender" value="${gender}"/>
                                                ${gender}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="form-group" style="text-align: left">
                                    <button class="btn btn-primary" 
                                            type="submit">Register</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </body>
</html>
