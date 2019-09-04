<%-- 
    Document   : standardRoom
    Created on : Jul 21, 2019, 6:12:59 PM
    Author     : HP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Promotion</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <!--            display slide-->
            <div class="slide-one-item home-slider owl-carousel">
                <c:forEach var="promotion" items="${promotion}">
                    <c:forEach var="category" items="${promotion.roomCategorys}">
                        <c:if test="${category.imageEntities.size()>0}">
                            <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/${category.imageEntities.get(0).name});" 
                                 data-aos="fade" data-stellar-background-ratio="0.5">
                                <div class="container">
                                    <div class="row align-items-center justify-content-center">
                                        <div class="col-md-7 mx-auto text-center section-heading" data-aos="fade" >

                                            <h2 class="col-md-7 mx-auto text-center section-heading"  style="color: #08c">${promotion.name}</h2>
                                            <h2 class="col-md-7 mx-auto text-center section-heading"  style="color: #28a745">${category.name}</h2>
                                            <h1 class="col-md-7 mx-auto text-center section-heading">${promotion.discount}%</h1>
                                            <h2 class="col-md-12 mx-auto text-center section-heading" style="color: #e17009"> From <fmt:formatDate type="date" value="${promotion.startDate}" pattern="dd/MM/yyyy" />
                                                To  <fmt:formatDate type="date" value="${promotion.endDate}" pattern="dd/MM/yyyy" /></h2>
                                        </div>
                                    </div>
                                </div>
                            </div>  
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </div>  
            <!--list promotion-->
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2  style="color: #08c">List Promotion</h2>
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
                            <form action="${pageContext.request.contextPath}/manager/search-promotion"
                                  method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" name="searchTxt" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <!--add-->
                        <div class="col-sm-6" style="text-align: right">
                            <button class="btn btn-info"
                                    onclick="location.href = '<c:url value="/manager/form-add-promotion"/>'">
                                Add Promotion</button>
                        </div>
                    </div>                  
                    <!--view list promotion-->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Name</th>
                                        <th>DisCount</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <!--                                        <th>Description</th>-->
                                        <th>Category</th>
                                        <th>Status</th>
                                        <th colspan="2">Action</th>
                                        <th>Update Status</th>

                                    </tr>
                                    <c:forEach var="promotion" items="${promotion}">
                                        <tr>
                                            <td>${promotion.name}</td>
                                            <td>${promotion.discount}%</td>
    <!--                                            <td>${promotion.description}</td>-->
                                            <td><fmt:formatDate type="date" value="${promotion.startDate}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate type="date" value="${promotion.endDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <c:forEach var="category" items="${promotion.roomCategorys}">
                                                    ${category.name}, 

                                                    <!--show image
                                                    <c:if test="${category.imageEntities.size()>0}">
                                                        <td> <img src="<c:url value="/resources/images/${category.imageEntities.get(0).name}"/>" 
                                                                  alt="Image"  title="category"class="img-fluid" width="100px" height="100px"></td> 
                                                    </c:if> -->

                                                </c:forEach>
                                            </td>  
                                            <c:if test="${promotion.status == 'UnAvailable'}">
                                                <td style="color: red">${promotion.status}</td></c:if>
                                            <c:if test="${promotion.status == 'Available'}">
                                                <td style="color: blue">${promotion.status}</td></c:if>
                                                <td>
                                                    <button  class="btn btn" style="color: green"
                                                             onclick="location.href = '<c:url value="update-promotion-form/${promotion.id}"/>'">
                                                    Update</button></td>
                                            <td> <button class="btn btn-primary " style="color: whitesmoke; width: 100px" 
                                                         onclick="location.href = '<c:url value="detail-promotion/${promotion.id}"/>'">
                                                    Detail</button>
                                            </td>
                                            <c:if test="${promotion.status == 'UnAvailable'}">
                                                <td style="color: red"><button  class="btn btn-info" style="color: #FFFF99"
                                                                                onclick="location.href = '<c:url value="active-promotion/${promotion.id}"/>'">
                                                        Available</button></td></c:if>
                                                    <c:if test="${promotion.status == 'Available'}">
                                                <td style="color: blue"><button  class="btn btn-block" style="color: #c7180c"
                                                                                 onclick="location.href = '<c:url value="block-promotion/${promotion.id}"/>'">
                                                        UnAvailable</button></td></c:if>
                                            </tr>
                                    </c:forEach>
                                    <c:if test="${promotion==null || fn:length(promotion)<=0}">
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
