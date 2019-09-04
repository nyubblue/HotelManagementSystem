/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.PromotionEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
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
public interface CategoryRepository extends CrudRepository<RoomCategory, Integer> {

    public List<RoomCategory> findByName(String name);

    @Query(value = "Select *from category c "
            + "where c.name Like ?1 "
            + "or c.status Like ?2 ",
            nativeQuery = true)
    public List<RoomCategory> findRoomCategoryByNameOrStatus(String name, String status);

//    @Query(value = "Select *from category c "
//            + "where c.name Like ?1 "
//            + "or c.status Like ?2 ",
//            nativeQuery = true)
    @Query(value = "Select distinct rc From RoomCategory rc "
            + "left join fetch rc.promotionEntities pe "
            + "where pe.id = ?1")
    public List<RoomCategory> findByPromotionId(int promotionId);

    @Query(value = "Select DISTINCT rc From RoomCategory rc "
            + "join rc.roomEntities r "
            + "left join r.bookingDetailEntities bd "
            + "left join bd.bookingEntity bk "
            + "Where ( (rc.status = 'available' And r.status = 'available') And "
            + "((bk.status !='ORDERED' OR bk.status is null ) OR "
            + "(( bk.status = 'ORDERED') And "
            + "( ?1 Not Between bk.check_in And bk.check_out) "
            + "And (?2 Not Between bk.check_in And bk.check_out) )))")
    List<RoomCategory> findCategorys(Date checkIn, Date checkOut);

    @Query(value = "Select rc From RoomCategory rc "
            + "Join rc.roomEntities r "
            + "join fetch rc.imageEntities img "
            + "Where r.id = ?1")
    RoomCategory findRoomCategory(int roomId);

    @Query(value = "Select distinct rc From RoomCategory rc "
            + "Left join fetch rc.promotionEntities pe ")
    List<RoomCategory> findCategories();

    // them
    @Query(value = "Select rc From RoomCategory rc Where rc.status = 'Available' ")
    List<RoomCategory> findViewedCategory();

    @Query(value = "Select distinct rc From RoomCategory rc "
            + "Left join fetch rc.promotionEntities pe "
            + "Where pe.startDate > ?1 "
            + "Order By pe.startDate ASC ")
    List<RoomCategory> findCategoriesPromotion(Date nowDate);

    @Query(value = "Select distinct rc From RoomCategory rc "
            + "Left join fetch rc.promotionEntities pe")
    List<RoomCategory> findCategoriesAll();

    @Query(value = "Select rc From RoomCategory rc "
            + "Join Fetch rc.imageEntities img "
            + "Join rc.roomEntities r "
            + "Where r.id = ?1 ")
    RoomCategory findCategoryByRoomId(int roomId);

}
