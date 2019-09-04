<%-- 
    Document   : view-detail-promotion
    Created on : Aug 18, 2019, 11:22:14 PM
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
            <!--list promotion-->
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mx-auto text-center mb-5 section-heading">
                            <h2 style="color: #08c">Promotion From ${promotion.startDate}
                                To ${promotion.endDate} </h2>
                        </div>
                    </div>
                    <!--Success/fail-->
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
                    <!--view detail-->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <tr>
                                        <th>Room Category </th>
                                        <th>Price </th>
                                        <th>DisCount</th>
                                        <th>Status</th>
                                        <th colspan="3" style="text-align: center">Image</th>
                                    </tr>
                                    <c:forEach var="category" items="${categorys}">
                                        <tr>
                                            <td>${category.name}</td>
                                            <td>$${category.price}</td>
                                            <td>${promotion.discount}%</td>
                                            <td>${promotion.status}</td>
                                            <td>
                                                <c:forEach var="images" items="${category.imageEntities}">
                                                    <img src="<c:url value="/resources/images/${images.name}"/>" 
                                                         alt="${images.name}" title="${images.name}" width="160" height="150">
                                                </c:forEach>
                                            </td> 

                                            <td><button  class="btn btn-primary" style="color: #ffffff"
                                                         onclick="location.href = '<c:url 
                                                             value="/manager/update-promotion-form/${promotion.id}"/>'">
                                                    Update</button></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--show image-->
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>

    </body>
</html>

