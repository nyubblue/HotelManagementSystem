/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.repositories.BookingDetailRepo;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author buynl
 */
@Service
public class BookingDetailService {

    @Autowired
    private BookingDetailRepo bookingDetailRepo;

    public List<BookingDetailEntity> findBookingDetailByBookingId(int bookingId) {
        return bookingDetailRepo.findBookingDetails(bookingId);
    }

    public List<BookingDetailEntity> findByBooking(BookingEntity entity) {
        return bookingDetailRepo.findByBookingEntity(entity);
    }

//    
    public BookingDetailEntity saveBookingDetail(BookingDetailEntity bookingDetail) {
        return bookingDetailRepo.save(bookingDetail);
    }

}
