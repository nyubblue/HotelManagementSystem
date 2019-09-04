/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HP
 */
@Repository
public interface ServiceRepository extends CrudRepository<ServiceEntity, Integer> {

    public List<ServiceEntity> findByName(String name);

    public List<ServiceEntity> findByBookingDetailsEntities(BookingDetailEntity bookingDetailEntity);

    @Query(value = "Select *from services s "
            + "where s.name Like ?1 "
            + "or s.status Like ?2 ",
            nativeQuery = true)
    public List<ServiceEntity> findServiceEntityByNameOrStatus(String name, String status);

    //
    @Query(value = "Select Distinct sv From ServiceEntity sv "
            + "Left Join Fetch sv.imageEntities img ")
    List<ServiceEntity> findServices();

    @Query(value = "Select Distinct sv From ServiceEntity sv "
            + "Join sv.bookingDetailsEntities bd "
            + "Where bd.id = ?1 ")
    List<ServiceEntity> findServicesByDetail_id(int id);
}
