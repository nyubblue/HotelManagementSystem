<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Booking -->

<div class="booking">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="booking_title text-center"><h2>Book a room</h2></div>
                <div class="booking_text text-center">
                    <p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse nec faucibus velit. Quisque eleifend orci ipsum, a bibendum lacus suscipit sit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse nec faucibus velit. Quisque eleifend orci ipsum, a bibendum lacus suscipit sit.</p>
                </div>

                <!-- Booking Slider -->
                <div class="booking_slider_container">
                    <div class="owl-carousel owl-theme booking_slider">

                        <!-- Slide -->
                        <div class="booking_item">
                            <div class="background_image" style="background-image:url(<c:url value="/resources/images/booking_1.jpg"/>)"></div>
                            <div class="booking_overlay trans_200"></div>
                            <div class="booking_price">$120/Night</div>
                            <div class="booking_link"><a href="booking.html">Family Room</a></div>
                        </div>

                        <!-- Slide -->
                        <div class="booking_item">
                            <div class="background_image" style="background-image:url(<c:url value="/resources/images/booking_2.jpg"/>)"></div>
                            <div class="booking_overlay trans_200"></div>
                            <div class="booking_price">$120/Night</div>
                            <div class="booking_link"><a href="booking.html">Deluxe Room</a></div>
                        </div>

                        <!-- Slide -->
                        <div class="booking_item">
                            <div class="background_image" style="background-image:url(<c:url value="/resources/images/booking_3.jpg"/>)"></div>
                            <div class="booking_overlay trans_200"></div>
                            <div class="booking_price">$120/Night</div>
                            <div class="booking_link"><a href="booking.html">Single Room</a></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>