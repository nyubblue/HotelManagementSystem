/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.domain.InvoiceItem;
import com.mycompany.jv30_hotel.domain.SearchHistory;
import com.mycompany.jv30_hotel.domain.SearchingFormDomain;
import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.enums.Gender;
import com.mycompany.jv30_hotel.service.AccountService;
import com.mycompany.jv30_hotel.service.BookingDetailService;
import com.mycompany.jv30_hotel.service.BookingService;
import com.mycompany.jv30_hotel.service.CategoryService;
import com.mycompany.jv30_hotel.service.ServService;
import com.mycompany.jv30_hotel.service.UserBookingManagementService;
import com.mycompany.jv30_hotel.utils.Formatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ServService servService;
    @Autowired
    private BookingService bookingService;
    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingDetailService bookingDetailService;

    @Autowired
    private UserBookingManagementService managementService;

    @RequestMapping("/home")
    public String viewHome(Model model) {
        model.addAttribute("message", "Welcome User");
        model.addAttribute("search_domain", new SearchingFormDomain());
        model.addAttribute("services", servService.getAvailableServices());
        model.addAttribute("categories", categoryService.getcategoryList());
        return "user/home";
    }

    @RequestMapping(value = "/searchBooking")
    public String submitSearchBooking(Model m, @ModelAttribute("search_domain") SearchingFormDomain formDomain,
            HttpSession session) {
        m.addAttribute("formDomain", formDomain);
        return "redirect:/searchBooking";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String showProfile(Model m, @RequestParam(required = false) String message) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity account = (AccountEntity) authentication.getPrincipal();
        if (account != null) {
            m.addAttribute("account", account);
        }
        m.addAttribute("message", message);
        m.addAttribute("genders", Gender.values());
        return "user/profile";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public String updateProfile(Model m, @ModelAttribute("account") AccountEntity account , RedirectAttributes rd ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity accountcc = (AccountEntity) authentication.getPrincipal();
        if (accountcc != null) {
            accountcc.setAddress(account.getAddress());
            Date birthday = account.getBirhDate();
            accountcc.setBirhDate(birthday);
            accountcc.setGender(account.getGender());
            accountcc.setFullName(account.getFullName());
            accountcc = accountService.save(accountcc);
            rd.addAttribute("message", "Update is sucessfull !");
            m.addAttribute("account", accountcc);
            return "redirect:/user/profile";
        }
        rd.addAttribute("message", "Update is failed !");
        return "redirect:/user/profile";
    }

    @RequestMapping(value = "/view_history", method = RequestMethod.GET)
    public String viewBookingList(Model m) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity account = (AccountEntity) authentication.getPrincipal();
        m.addAttribute("bookings", managementService.getUserBookings(account.getId()));
        m.addAttribute("searchHistory", new SearchHistory());
        return "user/listBooking";
    }

    @RequestMapping(value = "/search_history", method = RequestMethod.POST)
    public String searchBookingHistory(Model m, @ModelAttribute("searchHistory") SearchHistory searchHistory) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity account = (AccountEntity) authentication.getPrincipal();
        List<BookingEntity> bookings = managementService.getUserBookings(account.getId(), searchHistory.getStartDate(), searchHistory.getEndDate());
        m.addAttribute("bookings", bookings);
        return "user/listBooking";
    }

    @RequestMapping(value = "/detail/{bookingId}", method = RequestMethod.GET)
    public String viewDetail(Model m, @PathVariable("bookingId") int bookingId) {
        BookingEntity booking = managementService.getBookingHistory(bookingId);
        m.addAttribute("booking", booking);
        return "user/view_booking";
    }

    @RequestMapping("/downExel/{bookingId}")
    public String exportData(Model model, @PathVariable("bookingId") int bookingId) {
        BookingEntity booking = managementService.getBookingHistory(bookingId);
        List<InvoiceItem> invoiceItems = new ArrayList<>();
        for (BookingDetailEntity bookingDetail : booking.getBookingDetailEntities()) {
            InvoiceItem item = new InvoiceItem();
            item.setRoom_type(bookingDetail.getRoomEntity().getRoomCategory().getName());
            item.setRoom_numer(bookingDetail.getRoomEntity().getRoom_number());
            String services = "";
            List<ServiceEntity> listServ = bookingDetail.getServiceEntities();
            if (listServ == null || listServ.size() <= 0) {
            } else {
                for (ServiceEntity serv : bookingDetail.getServiceEntities()) {
                    services += serv.getName() + ", ";
                    item.setServices(services.substring(0, services.length() - 2));
                }
            }
            item.setPrice(String.valueOf(bookingDetail.getPrice()));
            invoiceItems.add(item);
        }
        InvoiceItem item = new InvoiceItem();
        item.setRoom_type("");
        item.setRoom_numer("");
        item.setServices("");
        item.setPrice("");
        invoiceItems.add(item);
         InvoiceItem item2 = new InvoiceItem();
        item2.setRoom_type("");
        item2.setRoom_numer("");
        item2.setServices("Total Price ");
        item2.setPrice(String.valueOf(booking.getTotal_price()));
        invoiceItems.add(item2);
        InvoiceItem item1 = new InvoiceItem();
        String checkIn = (new Formatter()).formatDate(booking.getCheck_in(), "dd/MM/yyyy");
        String checkout = (new Formatter()).formatDate(booking.getCheck_out(), "dd/MM/yyyy");
        item1.setRoom_type("CheckIn");
        item1.setRoom_numer(checkIn);
        item1.setServices("CheckOut");
        item1.setPrice(checkout);
        invoiceItems.add(item1);
        model.addAttribute("invoiceItems", invoiceItems);
        return "excelView1";
    }
    
}
