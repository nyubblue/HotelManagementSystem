/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import com.mycompany.jv30_hotel.entities.PromotionEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.repositories.BookingDetailRepo;
import com.mycompany.jv30_hotel.repositories.BookingRepository;
import com.mycompany.jv30_hotel.repositories.CategoryRepository;
import com.mycompany.jv30_hotel.repositories.CustomerRepository;
import com.mycompany.jv30_hotel.repositories.ImageRepository;
import com.mycompany.jv30_hotel.repositories.PromotionRepository;
import com.mycompany.jv30_hotel.repositories.RoomRepository;
import com.mycompany.jv30_hotel.repositories.ServiceRepository;
import com.mycompany.jv30_hotel.utils.Formatter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class BookingService {

    @Autowired
    private RoomRepository roomRepository;
    @Autowired
    private BookingRepository bookingRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private BookingDetailRepo bookingDetailRepo;
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private ServiceRepository serviceRepo;
    @Autowired
    private PromotionRepository promotionRepo;

    @Autowired
    private CustomerRepository customerRepository;

    public List<BookingEntity> findBookingByInOut(Date startDate, Date endDate) {
        return bookingRepository.getListByStartEnd(startDate, endDate);
    }

    public List<BookingEntity> getBooking() {
        return (List<BookingEntity>) bookingRepository.findAll();
    }

    public BookingEntity finyById(int id) {
        return bookingRepository.findOne(id);
    }

    //
    public BookingDetailEntity findBookingDetailById(int id) {
        return bookingDetailRepo.findOne(id);
    }

    public List<RoomEntity> findRoomsByCategoryDateAndCategoryId(Date d1, Date d2, int roomCategoryId) {
        String date1 = (new Formatter()).formatDate(d1);
        String date2 = (new Formatter()).formatDate(d2);
        List<RoomEntity> rooms = roomRepository.findRoomByDateNative(String.valueOf(roomCategoryId), date1, date2);
        if (rooms != null && rooms.size() > 0) {
            for (RoomEntity room : rooms) {
                RoomCategory category = categoryRepository.findOne(roomCategoryId);
                category.setDescriptions(category.getDescription().split(","));
                category.setConveniences(category.getConvenience().split(","));
                category.setImageEntities(imageRepository.findImage(roomCategoryId));
                List<PromotionEntity> promotions = promotionRepo.findPromotions(d1, roomCategoryId);
                category.setPromotionEntities(promotions);
                room.setRoomCategory(category);
            }
        }
        return rooms;
    }

    public List<RoomEntity> findRoomsByCategoryDateAndCategoryIds(Date d1, Date d2) {
        List<RoomEntity> rooms = roomRepository.findRoomEntity(d1, d2);
        if (rooms != null && rooms.size() > 0) {
            Iterator<RoomEntity> it = rooms.iterator();
            while (it.hasNext()) {
                RoomEntity room = it.next();
                int categoryId = room.getRoomCategory().getId();
                RoomCategory category = categoryRepository.findOne(categoryId);
                category.setDescriptions(category.getDescription().split(","));
                category.setConveniences(category.getConvenience().split(","));
                category.setImageEntities(imageRepository.findImage(categoryId));
                List<PromotionEntity> promotions = promotionRepo.findPromotions(d1, categoryId);
                category.setPromotionEntities(promotions);
                room.setRoomCategory(category);
            }
        }
        return rooms;
    }

    public RoomCategory findCategorybyId(int id) {
        return categoryRepository.findOne(id);
    }

    public BookingDetailEntity findOneDetail(int id) {
        return bookingDetailRepo.findOne(id);
    }

    public List<ServiceEntity> getServices() {
        return (List<ServiceEntity>) serviceRepo.findAll();
    }

    public ServiceEntity getAService(int servId) {
        return serviceRepo.findOne(servId);
    }

    public CustomerInfoEntity saveCustomerInfo(CustomerInfoEntity customer) {
        return customerRepository.save(customer);
    }

    public BookingEntity saveBooking(BookingEntity booking) {
        return bookingRepository.save(booking);
    }

    public void removeCustomer(int id) {
        customerRepository.delete(id);
    }

    public void removeBooking(int id) {
        bookingRepository.delete(id);
    }
}
