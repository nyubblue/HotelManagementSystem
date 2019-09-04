/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.domain.SearchCheck;
import com.mycompany.jv30_hotel.domain.ServiceDomain;
import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.enums.Gender;
import com.mycompany.jv30_hotel.service.BookingService;
import com.mycompany.jv30_hotel.service.CategoryService;
import com.mycompany.jv30_hotel.service.ReceptionService;
import com.mycompany.jv30_hotel.service.ServService;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author buynl
 */
@Controller
@RequestMapping("/reception")
public class ReceptionController {

    @Autowired
    private ReceptionService receptionService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ServService servService;

    @Autowired
    private BookingService bookingService;

    @RequestMapping(value = "/home")
    public String showHome(Model model, @RequestParam(value = "message", required = false) String message) {
        model.addAttribute("searchCheckIn", new SearchCheck());
        model.addAttribute("message", message);
        return "reception/home";
    }

    @RequestMapping(value = "/option_processes", method = RequestMethod.POST)
    public String processBookingData(@ModelAttribute("searchCheck") SearchCheck searchCheck, Model m) {
        BookingEntity booking = null;
        try {
            booking = receptionService.getBookingReception(searchCheck.getBookingCode());
        } catch (NullPointerException e) {
            return "redirect:/reception/home?message=Booking Code is not axists ! Please check information again. ";
        }
        List<BookingDetailEntity> details = booking.getBookingDetailEntities();
        for (int i = 0; i < details.size(); i++) {
            List<ServiceEntity> serviceShow = new ArrayList<>();
            if ((details.get(i).getServiceEntities()) != null) {
                List<ServiceEntity> services1 = details.get(i).getServiceEntities();
                List<ServiceEntity> refServices = bookingService.getServices();
                Iterator<ServiceEntity> it = refServices.iterator();
                while (it.hasNext()) {
                    ServiceEntity sv = it.next();
                    int svId = sv.getId();
                    boolean check = true;
                    for (ServiceEntity se : services1) {
                        if (svId == se.getId()) {
                            check = false;
                        }
                    }
                    if (check) {
                        serviceShow.add(sv);
                    }
                }
            }
            booking.getBookingDetailEntities().get(i).setServiceShow(serviceShow);
        }
        m.addAttribute("services", servService.getAvailableServices());
        m.addAttribute("booking", booking);
        return "reception/option_processes";
    }

    @RequestMapping(value = "/addService", method = RequestMethod.POST)
    public String viewBooking(Model m, @ModelAttribute("serviceForm") ServiceDomain serviceCmd) {
        BookingDetailEntity bookingDetail = receptionService.findBookingDetailListService(serviceCmd.getRoomId());
        List<ServiceEntity> services = bookingDetail.getServiceEntities();
        ServiceEntity service = receptionService.findService(serviceCmd.getServId());
        services.add(service);
        bookingDetail.getServiceEntities().add(service);
        double price = bookingDetail.getPrice() + service.getPrice();
        bookingDetail.setPrice(price);
        bookingDetail = receptionService.saveBookingDetail(bookingDetail);
        BookingEntity booking = receptionService.findBookingByBookingDetail_id(serviceCmd.getRoomId());
        double total = booking.getTotal_price() + service.getPrice();
        booking.setTotal_price(total);
        bookingService.saveBooking(booking);
        booking = receptionService.getBookingReception(booking.getId());
        List<BookingDetailEntity> details = booking.getBookingDetailEntities();
        for (int i = 0; i < details.size(); i++) {
            List<ServiceEntity> serviceShow = new ArrayList<>();
            if ((details.get(i).getServiceEntities()) != null) {
                List<ServiceEntity> services1 = details.get(i).getServiceEntities();
                List<ServiceEntity> refServices = bookingService.getServices();
                Iterator<ServiceEntity> it = refServices.iterator();
                while (it.hasNext()) {
                    ServiceEntity sv = it.next();
                    int svId = sv.getId();
                    boolean check = true;
                    for (ServiceEntity se : services1) {
                        if (svId == se.getId()) {
                            check = false;
                        }
                    }
                    if (check) {
                        serviceShow.add(sv);
                    }
                }
            }
            booking.getBookingDetailEntities().get(i).setServiceShow(serviceShow);
        }
        m.addAttribute("services", servService.getAvailableServices());
        m.addAttribute("booking", booking);
        return "reception/option_processes";
    }

    @RequestMapping(value = "/deleteServ/{servId}/{detaiId}")
    public String deleteService(Model m, @PathVariable("servId") int servId,
            @PathVariable("detaiId") int detaiId) {
        BookingDetailEntity bookingDetail = receptionService.findBookingDetailListService(detaiId);
        List<ServiceEntity> services = bookingDetail.getServiceEntities();
        ServiceEntity service = receptionService.findService(servId);
        Iterator<ServiceEntity> ti = services.iterator();
        int index = 0;
        while (ti.hasNext()) {
            ServiceEntity ser = ti.next();
            if (ser.getId() == servId) {
                index = services.indexOf(ser);
                break;
            }
        }
        services.remove(index);
        double price = bookingDetail.getPrice() - service.getPrice();
        bookingDetail.setPrice(price);
        bookingDetail = receptionService.saveBookingDetail(bookingDetail);
        BookingEntity booking = receptionService.findBookingByBookingDetail_id(detaiId);
        double total = booking.getTotal_price() - service.getPrice();
        booking.setTotal_price(total);
        bookingService.saveBooking(booking);
        booking = receptionService.getBookingReception(booking.getId());
        List<BookingDetailEntity> details = booking.getBookingDetailEntities();
        for (int i = 0; i < details.size(); i++) {
            List<ServiceEntity> serviceShow = new ArrayList<>();
            if ((details.get(i).getServiceEntities()) != null) {
                List<ServiceEntity> services1 = details.get(i).getServiceEntities();
                List<ServiceEntity> refServices = bookingService.getServices();
                Iterator<ServiceEntity> it = refServices.iterator();
                while (it.hasNext()) {
                    ServiceEntity sv = it.next();
                    int svId = sv.getId();
                    boolean check = true;
                    for (ServiceEntity se : services1) {
                        if (svId == se.getId()) {
                            check = false;
                        }
                    }
                    if (check) {
                        serviceShow.add(sv);
                    }
                }
            }
            booking.getBookingDetailEntities().get(i).setServiceShow(serviceShow);
        }
        m.addAttribute("services", servService.getAvailableServices());
        m.addAttribute("booking", booking);
        return "reception/option_processes";
    }

    @RequestMapping(value = "/check_info/{customerId}/{bookingId}")
    public String viewFormCheckIn(Model ra,
            @PathVariable("customerId") int customerId, @PathVariable("bookingId") int bookingId) {
        ra.addAttribute("bookingId", (Integer) bookingId);
        ra.addAttribute("customerId", (Integer) customerId);
        return "redirect:/reception/form-check-in";
    }

    @RequestMapping(value = "/form-check-in")
    public String viewFormIn(Model model, @ModelAttribute("customerId") int customerId,
            @ModelAttribute("bookingId") int bookingId) {
        String action = "";
        BookingEntity booking = receptionService.findBookingById(bookingId);
        if (booking.getStatus().equals("ORDERED")) {
            action = "reception/processCheckIn";
        }
        if (booking.getStatus().equals("IN")) {
            action = "reception/processCheckOut";
        }

        model.addAttribute("action", action);
        model.addAttribute("customerInfo", receptionService.findCustomerInfo(customerId));
        model.addAttribute("genders", Gender.values());
        model.addAttribute("bookingId", (Integer) bookingId);
        return "reception/checkin-form";
    }

    @RequestMapping(value = "/processCheckIn", method = RequestMethod.POST)
    public String saveCheckIn(@ModelAttribute("customerInfo") @Valid CustomerInfoEntity customer, BindingResult result,
            Model m) {
        if (result.hasErrors()) {
            m.addAttribute("customerInfo", customer);
            m.addAttribute("genders", Gender.values());
            return "reception/checkin-form";
        }
        CustomerInfoEntity temp = receptionService.saveCustomerInfo(customer);
        if (temp != null) {
            BookingEntity booking = receptionService.findBookingById(customer.getAccountEntity().getId());
            booking.setStatus("IN");
            bookingService.saveBooking(booking);
        }
        m.addAttribute("message", "Check In is finished !");
        return "redirect:/reception/home";
    }

    @RequestMapping(value = "/processCheckOut", method = RequestMethod.POST)
    public String saveCheckOut(@ModelAttribute("customerInfo") @Valid CustomerInfoEntity customer, BindingResult result,
            Model m) {
        if (result.hasErrors()) {
            m.addAttribute("customerInfo", customer);
            m.addAttribute("genders", Gender.values());
            return "reception/checkout-form";
        }
        CustomerInfoEntity temp = receptionService.saveCustomerInfo(customer);
        if (temp != null) {
            BookingEntity booking = receptionService.findBookingById(customer.getAccountEntity().getId());
            booking.setStatus("DONE");
            bookingService.saveBooking(booking);
        }
        m.addAttribute("message", "Check Out is finished !");
        return "redirect:/reception/home";
    }

    @RequestMapping(value = "/deleteDetail/{detailId}")
    public String delDetail(Model m, @PathVariable("detailId") int detailId) {
        BookingDetailEntity bookingDetail = receptionService.findBookingDetailListService(detailId);
        BookingEntity booking = receptionService.findBookingByBookingDetail_id(detailId);
        receptionService.deleteBookingDetail(detailId);
        double total = booking.getTotal_price() - bookingDetail.getPrice();
        booking.setTotal_price(total);
        bookingService.saveBooking(booking);
        booking = receptionService.getBookingReception(booking.getId());
        m.addAttribute("services", servService.getAvailableServices());
        m.addAttribute("booking", booking);
        return "reception/option_processes";
    }

    @InitBinder
    protected void initBinder(WebDataBinder binder) throws Exception {
        binder.registerCustomEditor(List.class, "serviceEntities", new CustomCollectionEditor(List.class) {
            @Override
            protected ServiceEntity convertElement(Object element) {
                if (element instanceof String) {
                    String id = (String) element;
                    ServiceEntity serviceEntity = servService.getServiceById(Integer.parseInt(id));
                    return serviceEntity;
                }
                return null;
            }
        });
    }
}
