<%-- 
    Document   : standardRoom
    Created on : Jul 21, 2019, 6:12:59 PM
    Author     : HP
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Service</title>
        <jsp:include page="../include/header.jsp" />
    </head>
    <body>
        <div class="site-wrap">
            <jsp:include page="../include/menu-site.jsp" />
            <div class="site-section bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
                            <h2 style="color: #08c">Services</h2>
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
                            <form action="${pageContext.request.contextPath}/manager/searchService" method="post" class="form-inline"  >
                                <input class="form-control mr-sm-2" name="searchTxt" placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>
                        <!--add-->
                        <div class="col-sm-6" style="text-align: right">
                            <button class="btn btn-info"
                                    onclick="location.href = '<c:url value="/manager/form-add-service"/>'">
                                Add Service</button>
                        </div>
                    </div>                  
                    <!--view service-->
                    <div class="row">
                        <c:forEach var="service" items="${service}">
                            <div class="col-md-6 col-lg-4 mb-5">
                                <div class="hotel-room text-center">
                                    <c:if test="${service.imageEntities.size()>0}">
                                        <a href="<c:url value="detail-service/${service.id}"/>" class="d-block mb-0 thumbnail">
                                            <img src="<c:url value="/resources/images/${service.imageEntities.get(0).name}"/>" 
                                                 alt="${service.name}"  title="${service.name}"class="img-fluid"></a>
                                        </c:if>
                                    <div class="hotel-room-body">
                                        <h3 class="heading mb-0"><a href="#">${service.name}</a></h3>
                                        <strong class="price">$${service.price}</strong>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <!--If-No-service-->
                        <div class="col-sm-6" >
                            <c:if test="${service==null || fn:length(service)<=0}">
                                <h5 style="color: red"
                                    >No Service</h5>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
    </body>
</html>
