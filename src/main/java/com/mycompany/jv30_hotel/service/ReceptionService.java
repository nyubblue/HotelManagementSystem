/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.repositories.BookingDetailRepo;
import com.mycompany.jv30_hotel.repositories.BookingRepository;
import com.mycompany.jv30_hotel.repositories.CategoryRepository;
import com.mycompany.jv30_hotel.repositories.CustomerRepository;
import com.mycompany.jv30_hotel.repositories.RoomRepository;
import com.mycompany.jv30_hotel.repositories.ServiceRepository;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author buynl
 */
@Service
public class ReceptionService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private BookingDetailRepo bookingDetailRepo;
    
    @Autowired
    private ServiceRepository serviceRepository;
    
    @Autowired
    private RoomRepository roomRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    

    public List<BookingEntity> getCheckIns(String idCard) {
        List<BookingEntity> bookings = bookingRepository.findBookingByCheckIn(new Date(), idCard);
        return bookings;
    }

    public CustomerInfoEntity findCustomerInfo(int customerId) {
        return customerRepository.findOne(customerId);
    }

    public CustomerInfoEntity saveCustomerInfo(CustomerInfoEntity customer) {
        return customerRepository.save(customer);
    }

    public BookingEntity findBookingById(int id) {
        return bookingRepository.findOne(id);
    }

    public List<BookingEntity> getCheckOuts(String idCard) {
        return bookingRepository.findBookingByCheckOut(new Date(), idCard);
    }

    //add 8/21
    public BookingEntity getBookingReception(int code) {
        BookingEntity booking = bookingRepository.findBookingReception(code);
        CustomerInfoEntity customer = customerRepository.findCustomerByBookingId(code);
        booking.setCustomerInfoEntity(customer);
        List<BookingDetailEntity> details = booking.getBookingDetailEntities();
        for(int i=0 ; i< details.size(); i++){
            RoomEntity room = roomRepository.findRoomByDetail_Id(details.get(i).getId());
            details.get(i).setRoomEntity(room);
            RoomCategory category = categoryRepository.findCategoryByRoomId(room.getId());
            category.setDescriptions(category.getDescription().split(","));
            room.setRoomCategory(category);
            List<ServiceEntity> services = serviceRepository.findServicesByDetail_id(details.get(i).getId());
            details.get(i).setServiceEntities(services);
        }
        booking.setBookingDetailEntities(details);
        return booking;
    }

    public BookingDetailEntity getBookingDetail(int id) {
        return bookingDetailRepo.findOne(id);
    }
    public BookingDetailEntity saveBookingDetail(BookingDetailEntity detail){
        return bookingDetailRepo.save(detail);
    }
    
    public ServiceEntity findService(int id){
        return serviceRepository.findOne(id);
    }
    
    public BookingEntity findBookingByBookingDetail_id(int bookingDetail_id){
        return bookingRepository.findBookingByBookingDetailId(bookingDetail_id);
    }
    
    public BookingDetailEntity findBookingDetailListService(int id){
       BookingDetailEntity detail = bookingDetailRepo.findOne(id);
       List<ServiceEntity> services = serviceRepository.findServicesByDetail_id(id);
       detail.setServiceEntities(services);
       return detail;
    }
    
    public void deleteBookingDetail(int id){
        bookingDetailRepo.delete(id);
    }
    
}
