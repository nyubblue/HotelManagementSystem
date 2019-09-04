/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.RoomEntity;
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
public interface RoomRepository extends CrudRepository<RoomEntity, Integer> {

    @Query(value = "Select *from rooms r "
            + "inner join category c on r.category_id = c.id "
            + "where c.name Like ?1 "
            + "or r.room_number Like ?2 "
            + "or r.status Like ?3 order by r.createAT desc ",
            nativeQuery = true)
    public List<RoomEntity> findRoomByCategoryOrNameOrStatus(String category, String name, String status);

    @Query(value = "Select *from rooms r "
            + "inner join category c on r.category_id = c.id "
            + "order by r.createAT desc ",
            nativeQuery = true)
    public List<RoomEntity> findRoomEntityOrderByCreateAT();

    @Query(value = "Select r From RoomEntity r "
            + "Join r.bookingDetailEntities bd "
            + "Where bd.id = ?1 ")
    RoomEntity findRoomByDetail_Id(int detail_id);

    @Query(value = "SELECT DISTINCT r.* from rooms r " + "INNER JOIN category rc on r.category_id = rc.id "
            + "LEFT JOIN bookingdetail bd on bd.room_entity_id = r.id "
            + "Left JOIN bookings bk on bk.id = bd.bookings_id "
            + "WHERE  r.status='Available' AND rc.status = 'Available' And rc.id = ?1 And "
            + "r.id Not In ( "
            + "Select r1.id from rooms r1 "
            + "left Join bookingdetail bd1 on bd1.room_entity_id = r1.id "
            + "Join bookings bk1 on bk1.id = bd1.bookings_id "
            + "Where ( bk1.status ='ORDERED' Or bk1.status = 'IN' ) And "
            + "(( ?2 between bk1.check_in And bk1.check_out) Or "
            + "( ?3 between bk1.check_in And bk1.check_out)))", nativeQuery = true)
    public List<RoomEntity> findRoomByDateNative(String roomCategoryId, String date1, String date2);

    @Query(value = "Select DISTINCT r From RoomEntity r " + "Join fetch r.roomCategory rc "
            + "Left Join r.bookingDetailEntities bd " + "left Join bd.bookingEntity bk "
            + "Where r.status='Available' AND rc.status = 'Available' And "
            + "r.id Not In ( "
            + "Select r1.id From RoomEntity r1 "
            + "Left Join r1.bookingDetailEntities bd1 "
            + "Left Join bd1.bookingEntity bk1 "
            + "Where ( bk1.status = 'ORDERED' Or bk1.status = 'IN' ) And  "
            + "(( ?1 between bk1.check_in And bk1.check_out ) Or "
            + "( ?2 between bk1.check_in And bk1.check_out )))")
    public List<RoomEntity> findRoomEntity(Date checkIn, Date checkOut);

    @Query(value = "Select r From RoomEntity r " + "join r.roomCategory rc where rc.id = ?1  ")
    List<RoomEntity> findRooms(int category_id);

    @Query("Select r From RoomEntity r "
            + "Join r.bookingDetailEntities bd "
            + "Join Fetch r.roomCategory rc "
            + "Where bd.id = ?1 ")
    RoomEntity findRoomIntialLazy(int bDetailId);

}
