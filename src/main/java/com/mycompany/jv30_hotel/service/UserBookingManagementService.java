/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.repositories.BookingDetailRepo;
import com.mycompany.jv30_hotel.repositories.BookingRepository;
import com.mycompany.jv30_hotel.repositories.CustomerRepository;
import com.mycompany.jv30_hotel.repositories.RoomRepository;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

/**
 *
 * @author buynl
 */
@Service
public class UserBookingManagementService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private BookingDetailRepo bookingDetailRepo;

    @Autowired
    private CustomerRepository customerRepository;
    
    @Autowired
    private RoomRepository roomRepository;

    public List<BookingEntity> getUserBookings(int accountId) {
        List<BookingEntity> bookings = bookingRepository.findBooking(accountId);
        Iterator<BookingEntity> it = bookings.iterator();
        while (it.hasNext()) {
            BookingEntity booking = it.next();
            int customerId = booking.getCustomerInfoEntity().getId();
            CustomerInfoEntity customer = customerRepository.findCustomer(accountId, customerId);
            booking.setCustomerInfoEntity(customer);
        }
        return bookings;
    }

    public List<BookingEntity> getUserBookings(int accountId, Date startDate, Date endDate) {
        List<BookingEntity> bookings = bookingRepository.findBooking(accountId, startDate, endDate);
        Iterator<BookingEntity> it = bookings.iterator();
        while (it.hasNext()) {
            BookingEntity booking = it.next();
            int customerId = booking.getCustomerInfoEntity().getId();
            CustomerInfoEntity customer = customerRepository.findCustomer(accountId, customerId);
            booking.setCustomerInfoEntity(customer);
        }
        return bookings;

    }
    
    public BookingEntity getBookingHistory(int bookingId){
        BookingEntity booking = bookingRepository.findOne(bookingId);
        List<BookingDetailEntity> bookingDetails = bookingDetailRepo.findBookingDetails(bookingId);
        Iterator<BookingDetailEntity> it = bookingDetails.iterator();
        while(it.hasNext()){
            BookingDetailEntity bookingDetail = it.next();
            int index = bookingDetails.indexOf(bookingDetail);
            int bDetailId = bookingDetail.getId();
            RoomEntity room = roomRepository.findRoomIntialLazy(bDetailId);
            bookingDetails.get(index).setRoomEntity(room);
        }
        booking.setBookingDetailEntities(bookingDetails);
        return booking;
    }
}
