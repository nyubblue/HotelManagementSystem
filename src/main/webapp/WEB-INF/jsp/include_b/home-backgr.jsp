<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<div class="home">
	<div class="home_slider_container">
		<div class="owl-carousel owl-theme home_slider">
			<div class="slide">
				<div class="background_image"
					style="background-image:url(<c:url value="resources_b/images/index_1.jpg"/>)"></div>
				<div class="home_container">
					<div class="container">
						<div class="row">
							<div class="col">
								<div class="home_content text-center">
									<div class="home_title">A Luxury Stay</div>
									<div class="booking_form_container">
										<form:form
											action="${pageContext.request.contextPath}/searchBooking"
											modelAttribute="search_domain" cssClass="booking_form">
											<div
												class="d-flex flex-xl-row flex-column align-items-start justify-content-start">
												<div
													class="booking_input_container d-flex flex-lg-row flex-column align-items-start justify-content-start">
													<c:if test="${booking == null}">
														<div>
															<input name="checkIn" type="text"
																class="datepicker booking_input booking_input_a booking_in"
																placeholder="Check in">
														</div>
														<div>
															<input name="checkOut" type="text"
																class="datepicker booking_input booking_input_a booking_out"
																placeholder="Check out">
														</div>
													</c:if>
													<div class="wrap_select">
														<select name="roomCategoryId"
															class="custom-select mybooking_input_select">

															<option value="0">Room Type</option>
															<option value="1">Single Room</option>
															<option value="2">Family Room</option>
														</select>
													</div>
													<div>
														<button type="submit" class="booking_button trans_200">Book
															Now</button>
													</div>
												</div>
											</div>
										</form:form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</html>
