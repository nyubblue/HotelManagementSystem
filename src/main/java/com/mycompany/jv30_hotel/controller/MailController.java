package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.utils.Formatter;
import java.util.List;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author buynl
 */
@Controller
public class MailController {

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping(value = "/sendMail")
    public String sendEmail(Model model,
            HttpSession session) throws MessagingException {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        CustomerInfoEntity customer = (CustomerInfoEntity) session.getAttribute("customerInfo");
        if (customer != null && booking != null) {
            MimeMessage message = mailSender.createMimeMessage();
            boolean multipart = true;
            MimeMessageHelper helper = new MimeMessageHelper(message, multipart, "utf-8");

            String htmlMsg = "<head><style>table,tr,th,td{border:1px solid black; border-collapse:"
                    + " collapse; text-align: center;}</style></head><body><h1>Welcome to B&T hotel !</h1><h3>Your Invoice :</h3>"
                    + "<h3>Booking Code  :  "+booking.getId()+"</h3><br> "
                    + "<h2 style='color:cyan;'>Customer : " + customer.getFullName() + "</h2>"
                    + "<h3 style='color:cyan;'>Check In : " + (new Formatter()).formatDate(booking.getCheck_in(), "dd-MM-yyyy") + "</h3>"
                    + "<h3 style='color:cyan;'>Check Out: " + (new Formatter()).formatDate(booking.getCheck_out(), "dd-MM-yyyy") + "</h3><br><br>"
                    + "<table style='width:600px;'><tr><th>Room Type</th><th>Room</th><th>Service</th><th>Price</th></tr>";

            String temp = "";
            List<BookingDetailEntity> list = booking.getBookingDetailEntities();
            for (BookingDetailEntity bd : list) {
                String str = "";
                str += "<tr><td>" + bd.getRoomEntity().getRoomCategory().getName() + "</td><td>" + bd.getRoomEntity().getRoom_number() + "</td><td>";
                if (bd.getServiceEntities() != null) {
                    for (ServiceEntity serv : bd.getServiceEntities()) {
                        if (bd.getServiceEntities().indexOf(serv) == (bd.getServiceEntities().size() - 1)) {
                            str += serv.getName();
                        } else {
                            str += serv.getName() + " ,";
                        }
                    }
                } else {
                    str += "No Service ";
                }
                str += "</td><td>" + bd.getPrice() + "</td></tr>";
                    temp +=str;
            }
            htmlMsg += temp;
            htmlMsg += "<tr  style='background: grey; color:white;' ><td><h3>Total Price</h3></td><td colspan='3'><h3>" + booking.getTotal_price() + "</h3></td></tr></table><br><br>"
                    + "<h2>Thank for choosing Us</h2></body>";
            message.setContent(htmlMsg, "text/html");
            helper.setTo(customer.getEmail());
            helper.setSubject("Booking Info");
            mailSender.send(message);
            session.removeAttribute("booking");
            session.removeAttribute("customerInfo");
            return "redirect:/terminal?message=A Email has been sent to you to confirm !";
        } else {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (!(authentication instanceof AnonymousAuthenticationToken)) {
                AccountEntity account = (AccountEntity) authentication.getPrincipal();
                session.removeAttribute("booking");
                session.removeAttribute("customerInfo");

                return "redirect:/user/home";
            } else {
                return "redirect:/home";
            }
        }
    }

    @RequestMapping(value = "/sendMailActive")
    public String createSendMailActive(Model m, @ModelAttribute("account") AccountEntity account) {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(account.getEmail());
        email.setSubject("Active Account");
        email.setText("Please Click a link:" + "http://localhost:8084/JV30_Hotel/active/" + account.getId() + " to active your account .");
        mailSender.send(email);
        return "redirect:/terminal?message=Your registration is finished !. Please check your email to active .";
    }

}
