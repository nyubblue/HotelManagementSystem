<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- Menu -->
<!DOCTYPE html>
<html>
<body>
<div class="menu trans_400 d-flex flex-column align-items-end justify-content-start">
    <div class="menu_close"><i class="fa fa-times" aria-hidden="true"></i></div>
    <div class="menu_content">
        <nav class="menu_nav text-right">
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="about.html">About us</a></li>
                <li><a href="#">Rooms</a></li>
                <li><a href="<c:url value="/services" />" >Services</a></li>
            </ul>
        </nav>
    </div>
    <div class="menu_extra">
        <div class="menu_book text-right"><a href="#">Book online</a></div>
        <div class="menu_phone d-flex flex-row align-items-center justify-content-center">
            <img src="<c:url value="/resources_b/images/phone-2.png"/>" alt="PHOTO">
            <span>0183-12345678</span>
        </div>
    </div>
</div>
</body>
</html>