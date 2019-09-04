/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.BookingEntity;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HP
 */
@Repository
public interface BookingRepository extends CrudRepository<BookingEntity, Serializable> {

    @Query(value = "SELECT b FROM  BookingEntity  b  where b.booking_date between ?1 and ?2 "
            + "order by b.booking_date DESC")
    public List<BookingEntity> getListByStartEnd(Date startDate, Date endDate);

    @Query(value = "Select be From BookingEntity be "
            + "join be.customerInfoEntity c  "
            + "join c.accountEntity acc "
            + "where acc.id = ?1 "
            + "Order By be.booking_date ")
    public List<BookingEntity> findBooking(int accountId);

    @Query(value = "Select be From BookingEntity be "
            + "join be.customerInfoEntity c  "
            + "join c.accountEntity acc "
            + "where acc.id = ?1 And (be.booking_date Between ?2 And ?3 ) "
            + "Order By be.booking_date DESC")
    public List<BookingEntity> findBooking(int accountId, Date date1, Date date2);
//

    @Query(value = "Select bk From BookingEntity bk "
            + "Join Fetch bk.customerInfoEntity ci "
            + "Where bk.check_in = ?1 And ci.idCard = ?2 And bk.status = 'ORDERED' ")
    List<BookingEntity> findBookingByCheckIn(Date checkIn, String idCard);

    @Query(value = "Select bk From BookingEntity bk "
            + "Join Fetch bk.customerInfoEntity ci "
            + "Where bk.check_out = ?1 And ci.idCard = ?2 And bk.status = 'CheckIn' ")
    List<BookingEntity> findBookingByCheckOut(Date checkIn, String idCard);

    @Query(value = "Select bk From BookingEntity bk "
            + "Join Fetch bk.bookingDetailEntities bd "
            + "Where bk.id = ?1 ")
    BookingEntity findBookingReception(int bookingId);

    @Query(value = "Select bk From BookingEntity bk "
            + "Join bk.bookingDetailEntities bd "
            + "Where bd.id = ?1 ")
    BookingEntity findBookingByBookingDetailId(int bookingDetailId);
}
