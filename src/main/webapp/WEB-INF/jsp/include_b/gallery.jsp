<%@taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<div class="gallery">
    <div class="gallery_slider_container">
        <div class="owl-carousel owl-theme gallery_slider">

            <!-- Slide -->
            <div class="gallery_item">
                <div class="background_image" style="background-image:url(<c:url value="/resources/images/gallery_1.jpg"/>)"></div>
                <a class="colorbox" href="<c:url value="/resources/images/gallery_1.jpg" />"></a>
            </div>

            <!-- Slide -->
            <div class="gallery_item">
                <div class="background_image" style="background-image:url(<c:url value="/resources/images/images/gallery_2.jpg"/>)"></div>
                <a class="colorbox" href="<c:url value="/resources/images/gallery_2.jpg" />"></a>
            </div>

            <!-- Slide -->
            <div class="gallery_item">
                <div class="background_image" style="background-image:url(<c:url value="/resources/images/images/gallery_3.jpg"/>)"></div>
                <a class="colorbox" href="<c:url value="/resources/images/gallery_3.jpg"/>" ></a>
            </div>

            Slide
            <div class="gallery_item">
                <div class="background_image" style="background-image:url(<c:url value="/resources/images/images/gallery_4.jpg"/>)"></div>
                <a class="colorbox" href="<c:url value="/resources/images/gallery_4.jpg"/> "></a>
            </div>

        </div>
    </div>
</div>