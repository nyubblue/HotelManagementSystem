/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.sun.istack.Nullable;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author buynl
 */
@Repository
public interface BookingDetailRepo extends CrudRepository<BookingDetailEntity, Integer> {

    @Query("Select Distinct bd From BookingDetailEntity bd "
            + "Join bd.bookingEntity bk "
            + "Left Join Fetch bd.serviceEntities serv "
            + "Where bk.id = ?1 "
            + "Order By bk.booking_date DESC")
    List<BookingDetailEntity> findBookingDetails(int bookingId);

    public List<BookingDetailEntity> findByBookingEntity(BookingEntity entity);

}
