<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <jsp:include page="../include/header.jsp"></jsp:include>
        <jsp:include page="../include_b/header-css.jsp"></jsp:include>
        </head>
        <body>
            <div class="site-wrap">
                <div class="site-navbar-wrap js-site-navbar bg-white scrolled">
                    <div class="container">
                        <div class="site-navbar bg-light">
                            <div class="py-1">
                                <div class="row align-items-center">
                                    <div class="col-12">
                                        <nav class="site-navigation text-right" role="navigation">
                                            <div class="container">
                                                <div class="d-inline-block d-lg-none  ml-md-0 mr-auto py-3"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu h3"></span></a></div>
                                                <ul class="site-menu js-clone-nav d-none d-lg-block">
                                                    <li class="active">
                                                        <a href="<c:url value="/user/home" />">Home</a>
                                                </li>
                                                <sec:authorize access="isAuthenticated()">
                                                    <li>  <a href="<c:url value="/user/profile" />">Profile</a></li>  
                                                    <li>  <a href="<c:url value="/user/view_history" />">History</a></li>  
                                                    <li>  <a href="<c:url value="/logout" />">Logout</a></li>  
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                    <li><a href="<c:url value="/login" />">Login</a></li>
                                                    <li><a href="<c:url value="/register" />">Register</a></li>  
                                                    </sec:authorize>
                                            </ul>
                                        </div>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="slide-one-item home-slider owl-carousel">
                <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/hero_1.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">

                                <h1 class="mb-2">Welcome To Suites</h1>
                                <h2 class="caption">Hotel &amp; Resort</h2>
                            </div>
                        </div>
                    </div>
                </div>  

                <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/hero_2.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Unique Experience</h1>
                                <h2 class="caption">Enjoy With Us</h2>
                            </div>
                        </div>
                    </div>
                </div> 

                <div class="site-blocks-cover overlay" style="background-image: url(../resources/images/hero_3.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center justify-content-center">
                            <div class="col-md-7 text-center" data-aos="fade">
                                <h1 class="mb-2">Relaxing Room</h1>
                                <h2 class="caption">Your Room, Your Stay</h2>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>


            <div class="bg-white">
                <div class="container  bg-light">
                    <fieldset class=" border m-2 fieldset">
                        <legend  class="w-auto"><h2 class="text-success">Profile</h2></legend>
                        <div class="row">
                            <div class="col-sm-12">
                                <form:form action="${pageContext.request.contextPath}/user/profile" method="post" 
                                           modelAttribute="account" class="form-horizontal">
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">
                                            Full Name</label>
                                        <div class="col-sm-8">
                                            <input name="fullName" value="${account.fullName}" class="form-control"/>
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
                                                type="submit">update</button>
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


            < <div class="py-5 quick-contact-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <div>
                                <span class="icon-room text-white h2 d-block"></span>
                                <h2>Location</h2>
                                <p class="mb-0">New York - 2398 <br>  10 Hadson Carl Street</p>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div>
                                <span class="icon-clock-o text-white h2 d-block"></span>
                                <h2>Service Times</h2>
                                <p class="mb-0">Wednesdays at 6:30PM - 7:30PM <br>
                                    Fridays at Sunset - 7:30PM <br>
                                    Saturdays at 8:00AM - Sunset</p>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div>
                                <span class="icon-comments text-white h2 d-block"></span>
                                <h2>Get In Touch</h2>
                                <p class="mb-0">Email: info@yoursite.com <br>
                                    Phone: (123) 3240-345-9348 </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="../include/footer.jsp" />
        </div>
        <jsp:include page="../include/footer-script.jsp"/>
        <jsp:include page="../include_b/footer-script.jsp"/>
    </body>
</html>