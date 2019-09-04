/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.service.BookingDetailService;
import com.mycompany.jv30_hotel.service.BookingService;
import com.mycompany.jv30_hotel.service.HotelService;
import com.mycompany.jv30_hotel.service.UserBookingManagementService;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Formatter;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/manager")
public class BookingController {

    @Autowired
    private BookingService bookingService;
    @Autowired
    private BookingDetailService detailService;

    @Autowired
    private HotelService hotelService;

    @RequestMapping(value = "list-booking", method = RequestMethod.GET)
    public String viewBooking(Model model, HttpSession session,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {

        List<BookingEntity> bookingEntitys = bookingService.getBooking();
        for (BookingEntity bookingEntity : bookingEntitys) {
            List<BookingDetailEntity> detailEntitys = detailService.findByBooking(bookingEntity);
            for (BookingDetailEntity detailEntity : detailEntitys) {
                List<ServiceEntity> entitys = hotelService.findByBookingDetail(detailEntity);
                detailEntity.setServiceEntities(entitys);
            }
            bookingEntity.setBookingDetailEntities(detailEntitys);
        }
//        for (BookingEntity bookingEntity : bookingEntitys) {
//            bookingEntity = bookingManagementService.getBookingHistory(bookingEntity.getId());
//        }
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("booking", bookingEntitys);
        session.setAttribute("booking", bookingEntitys);
        return "manager/list-booking";

    }

    @RequestMapping(value = "find-booking", method = RequestMethod.POST)
    public String searchBooking(Model model,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date check_in,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date check_out,
            HttpSession session) {

        List<BookingEntity> bookingEntitys = bookingService.findBookingByInOut(check_in, check_out);
        for (BookingEntity bookingEntity : bookingEntitys) {
            List<BookingDetailEntity> detailEntitys = detailService.findByBooking(bookingEntity);
            for (BookingDetailEntity detailEntity : detailEntitys) {
                List<ServiceEntity> entitys = hotelService.findByBookingDetail(detailEntity);
                detailEntity.setServiceEntities(entitys);
            }
            bookingEntity.setBookingDetailEntities(detailEntitys);
        }
        model.addAttribute("check_in", check_in);
        model.addAttribute("check_out", check_out);
        model.addAttribute("booking", bookingEntitys);
        session.setAttribute("booking", bookingEntitys);
        return "manager/find-booking-date";
    }

    @RequestMapping("/booking-detail/{bookingId}")
    public String viewBookingDetail(Model model, @PathVariable("bookingId") int bookingId, HttpSession session) {
        BookingEntity bookingEntity = bookingService.finyById(bookingId);
        List<BookingDetailEntity> bookingDetailEntitys = detailService.findBookingDetailByBookingId(bookingId);
        for (BookingDetailEntity detailEntity : bookingDetailEntitys) {
            List<ServiceEntity> entitys = hotelService.findByBookingDetail(detailEntity);
            detailEntity.setServiceEntities(entitys);
        }
        bookingEntity.setBookingDetailEntities(bookingDetailEntitys);
        model.addAttribute("booking", bookingEntity);
        session.setAttribute("booking", bookingEntity);
        return "manager/view-detail-booking";
    }

    @RequestMapping(value = "/downloadExcel")
    public String downloadExcel(Model model,
            HttpSession session) {
        model.addAttribute("booking", session.getAttribute("booking"));
        return "excelView";
    }

    @RequestMapping(value = "/pdf-view/{bookingId}")
    public String downloadExceldetail(Model model, @PathVariable("bookingId") int bookingId,
            HttpSession session) {
        model.addAttribute("bookingDetail", session.getAttribute("booking"));
        return "pdf";
    }

    @RequestMapping(value = "/pdf-view")
    public String viewPdfFile(Model model, HttpSession session) {
//        List<BookingEntity> bookingEntitys = bookingService.getBooking();
        model.addAttribute("booking", session.getAttribute("bookingPdf"));
        return "pdf";
    }

    @RequestMapping(value = "update-status/{bookingId}", method = RequestMethod.POST)
    public String updateStatus(Model model,
            @RequestParam(value = "status") String status,
            @PathVariable("bookingId") int bookingId) {

        BookingEntity bookingEntity = bookingService.finyById(bookingId);

        switch (status) {
            case "done":
                bookingEntity.setStatus("DONE");
                bookingService.saveBooking(bookingEntity);
                break;
            case "in":
                bookingEntity.setStatus("IN");
                bookingService.saveBooking(bookingEntity);
                break;
            case "order":
                bookingEntity.setStatus("ORDERED");
                bookingService.saveBooking(bookingEntity);
                break;
        }

        return "redirect:/manager/list-booking?messages=Update status "
                + bookingEntity.getStatus() + " for " + bookingEntity.getCustomerInfoEntity().getFullName() + "  is successful"
                + "&status=success";
    }

}
