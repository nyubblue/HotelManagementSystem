<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Searched Rooms</title>
        <jsp:include page="include_b/header-css.jsp"></jsp:include>
        <jsp:include page="include/header.jsp"></jsp:include>
        </head>
        <body>
            <div class="site-wrap">
            <jsp:include page="include_b/header_home.jsp"/>

            <div class="site-section bg-light">
                <div class="container">
                    <div class=" flex-box col-md-4 mx-auto text-center mb-6 section-heading align-items-center mb-0 pb-0">
                        <div class="booking_form_container mybk p-3">
                            <form:form
                                action="${pageContext.request.contextPath}/searchBooking"
                                modelAttribute="search_domain" cssClass="booking_form">
                                <div
                                    class=" d-flex flex-lg-row flex-column align-items-start justify-content-start">
                                    <c:if test="${booking == null}">
                                        <div>
                                            <input name="checkIn" type="text"
                                                   class="datepicker buttonbk booking_in"
                                                   placeholder="Check in">
                                        </div>
                                        <div>
                                            <input name="checkOut" type="text"
                                                   class="datepicker buttonbk booking_out"
                                                   placeholder="Check out">
                                        </div>
                                    </c:if>
                                    <div >
                                        <select name="roomCategoryId"
                                                class="custom-select buttonbk">
                                            <option selected value="0">Room Type</option>
                                            <c:forEach var="category" items="${categoryList}" >
                                                <option value="${category.id}">${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="ml-4">
                                        <button type="submit" class="booking_button trans_200">Book
                                            Now</button>
                                    </div>
                                </div>
                            </form:form>
                        </div >

                    </div>
                    <div class="col-md-6 mx-auto text-center mb-section-heading mt-0 pt-0">
                        <fmt:formatDate pattern="dd-MM-yyyy" value="${booking.check_in}"
                                        var="f1" />
                        <fmt:formatDate pattern="dd-MM-yyyy" value="${booking.check_out}"
                                        var="f2" />
                        <div > <h3><span class="badge badge-secondary mybk">CheckIn: ${f1}  CheckOut: ${f2} </span></h3></div>
                    </div>

                    <!--                    Cart -->

                    <div class="bg-light" style="font-family: inherit;">
                        <table class="table  table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="col-sm-1 text-center">Room</th>
                                    <th class="col-sm-4 text-center">Information</th>
                                    <th class="col-sm-3 text-center">Services</th>
                                    <th class="col-sm-2 text-center">Price</th>
                                    <th class="col-sm-2 text-center">Option</th>
                                </tr>
                            </thead>
                            <tbody class="lightSpeedIn">
                                <c:forEach var="bookingDetail" 
                                           items="${booking.bookingDetailEntities}" varStatus="ss">
                                    <tr>
                                        <td class="col-sm-2">
                                            <div>
                                                <img width="100%" height="300"
                                                     src='<c:url value="resources/images/${bookingDetail.roomEntity.roomCategory.imageEntities[0].name}" />'
                                                     class="figure-img img-fluid rounded" alt="atl">
                                            </div>
                                            <div>
                                                <h3 class="text-center">${bookingDetail.roomEntity.room_number}</h3>
                                            </div>
                                        </td>

                                        <td class="col-sm-3">
                                            <div>
                                                <div>
                                                    <h2 class="text-center" style="font-weight: bold;"> ${bookingDetail.roomEntity.roomCategory.name}</h2>
                                                    <p class="text-center text-dark mb-2">___________________________</p>
                                                    <c:forEach var="des" items="${bookingDetail.roomEntity.roomCategory.descriptions}">
                                                        <h5 class="text-dark"><span class="text-info">&#10021;</span> ${des}</h5>
                                                    </c:forEach>
                                                </div>
                                                <c:if test="${not empty bookingDetail.roomEntity.roomCategory.promotionEntities}">
                                                    <h2>
                                                        <span class="badge badge-secondary">${bookingDetail.roomEntity.roomCategory.promotionEntities[0].discount}%</span>
                                                    </h2>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td class="col-sm-5"><form:form 
                                                action="addService"
                                                modelAttribute="serviceForm" method="post">
                                                <div class="mb-2">
                                                    <select  name="servId"
                                                             class="custom-select">
                                                        <option selected>Select Service</option>
                                                        <c:if test="${empty bookingDetail.serviceEntities}">
                                                            <c:forEach var="serv" items="${services}">
                                                                <option value="${serv.id}">${serv.name}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${not empty bookingDetail.serviceEntities}">
                                                            <c:forEach var="serv" items="${bookingDetail.serviceShow}">
                                                                <option value="${serv.id}">${serv.name}</option>
                                                            </c:forEach>
                                                        </c:if>

                                                    </select>
                                                </div>
                                                <input  name="roomId"
                                                        value="${bookingDetail.id}" hidden="true" />
                                                <button  class="btn btn-primary" type="submit">Update Services</button>

                                            </form:form>
                                            <c:if test="${empty bookingDetail.serviceEntities}" >
                                                <div class="alert alert-info mt-4" role="alert"> 
                                                    No Service
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty bookingDetail.serviceEntities}">
                                                <div class="alert alert-success mt-4" role="alert"> 
                                                    <c:forEach var="service" items="${bookingDetail.serviceEntities}">
                                                        <div class="d-flex">
                                                            <div class="flex-fill justify-content-start">
                                                                ${service.name}</div> 
                                                            <div class="flex-fill justify-content-end">
                                                                <button type="button" class="close" aria-label="Close"
                                                                        onclick='location.href = "<c:url value="/deleteServ/${service.id}/${bookingDetail.id}"/> "''>
                                                                    <span  aria-hidden="true">&times;</span>
                                                                </button> 
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td class="col-sm-1"><h3>$${bookingDetail.price}</h3></td>
                                        <td class="col-sm-2">
                                            <button 
                                                onclick='location.href = "<c:url value="/deleteOne/${bookingDetail.id}"/> "'
                                                type="button" class="btn btn-danger">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-dark text-white">
                                <tr>

                                    <td colspan="5" >
                                        <div class="d-flex justify-content-center"><h2 class=" text-white ">Total Price      <fmt:formatNumber value="${booking.total_price}" type="currency"/></h2></div>

                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="d-flex flex-row-reverse bd-highlight" >
                            <div class="p-2 bd-highlight">
                                <button class="btn btn-success" onclick='location.href = "<c:url value="/customInfo"/> "'
                                        >Done Booking</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal_cancel">
                                    Cancel
                                </button>
                            </div>
                            <!--                            modal-->
                            <div class="modal" id="modal_cancel">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <!--                                        Header-->
                                        <div class="modal-header">
                                            <h4 class="modal-title">Do you want to delete this booking ? </h4>
                                        </div>
                                        <!--                                        footer model-->
                                        <!-- Modal footer -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                            <button type="button" class="btn btn-warning" data-dismiss="modal"
                                                    onclick='location.href = "<c:url value="/cancelBooking"/> "'>Yes</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button class="btn btn-primary" type="button"
                                        onclick='location.href = "<c:url value="/continue/${categoryId}"/> "'>
                                    Continue Booking</button>
                            </div>
                        </div>
                    </div>

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

            <jsp:include page="include/footer.jsp" />
        </div>
        <jsp:include page="include/footer-script.jsp"/>
        <jsp:include page="include_b/footer-script.jsp"/>
    </body>
</html>
