<%-- 
    Document   : home
    Created on : Jul 16, 2019, 8:06:44 PM
    Author     : HP
--%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
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
            <jsp:include page="menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-2 section-heading">
                            <h2 style="color: #08c">List Account</h2>
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
                        <!--searchRoom-->
                        <div class="col-sm-6" style="padding-bottom: 5px">
                            <form action="${pageContext.request.contextPath}/admin/search" method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" name="searchTxt" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <div class="col-sm-6" style="text-align: right">
                            <button class="btn btn-outline-success"
                                    onclick="location.href = '<c:url value="/admin/form-add-account"/>'">
                                Add Account</button>
                        </div>
                    </div>                  
                    <!--Account table-->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <tr>
                                        <th>No.</th>
                                        <th>Email</th>
                                        <th>Full Name</th>
                                        <th>Password</th>
                                        <!--                                        <th>Address</th>-->
                                        <!--                                        <th>Gender</th>-->
                                        <th>Birthday</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                        <th>Update Status</th>

                                    </tr>
                                    <c:set var = "count"  value = "1"/>
                                    <c:forEach var="account" items="${account}">
                                        <tr>
                                            <td><c:out value = "${count}"/></td>
                                            <td>${account.email}</td>
                                            <td>${account.fullName}</td>
                                            <td>${account.password}</td>
<!--                                            <td>${account.address}</td>-->
<!--                                            <td>${account.gender}</td>-->
                                            <td><fmt:formatDate type="date" value="${account.birhDate}" pattern="dd/MM/yyyy" /></td>
                                            <c:forEach var="role" items="${account.accountRoles}">
                                                <td>${role.role}</td>  
                                            </c:forEach>
                                            <c:if test="${account.status == 'Block'}">
                                                <td style="color: red">${account.status}</td></c:if>
                                            <c:if test="${account.status == 'Active'}">
                                                <td style="color: blue">${account.status}</td></c:if>
                                                <td >
                                                    <button  class="btn btn-info" style="color: #ffffff"
                                                             onclick="location.href = '<c:url value="update-account-form/${account.id}"/>'">
                                                    Update</button>
                                            </td>
                                            <c:if test="${account.status == 'Block'}">
                                                <td style="color: red"><button  class="btn btn-info" style="color: #FFFF99"
                                                                                onclick="location.href = '<c:url value="active/${account.id}"/>'">
                                                        Active</button></td></c:if>
                                                    <c:if test="${account.status == 'Active'}">
                                                <td style="color: blue"><button  class="btn btn-block" style="color: #c7180c"
                                                                                 onclick="location.href = '<c:url value="block/${account.id}"/>'">
                                                        Block</button></td></c:if>
                                                    <c:set var = "count"  value = "${count+1}"/>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${account==null || fn:length(account)<=0}">
                                        <tr>
                                            <td style="color: red"
                                                colspan="8">No Account found</td>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>
