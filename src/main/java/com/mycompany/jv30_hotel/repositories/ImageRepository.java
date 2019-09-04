/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
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
public interface ImageRepository extends CrudRepository<ImageEntity, Integer> {

    @Query(value = "Select * from images where category_id =?", nativeQuery = true)
    public List<ImageEntity> findImageEntityByCategoryIdNative(int categoryId);

    @Query(value = "Select * from images where services_id =?", nativeQuery = true)
    public List<ImageEntity> findImageEntityByServiceIdNative(int categoryId);

    public List<ImageEntity> findByRoomCategory(RoomCategory roomCategory);

    public List<ImageEntity> findByServiceEntity(ServiceEntity entity);
//
//    @Query(value = "delete from images where images.id = ?1", nativeQuery = true)
//    public void deleteImage(int id);

    @Query(value = "Select img From ImageEntity img "
            + "join img.roomCategory rc where rc.id = ?1  ")
    List<ImageEntity> findImage(int category_id);

}
