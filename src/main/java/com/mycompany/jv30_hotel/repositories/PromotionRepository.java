/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.PromotionEntity;
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
public interface PromotionRepository extends CrudRepository<PromotionEntity, Integer> {

    @Query("Select distinct pro From PromotionEntity pro "
            + "Join fetch pro.roomCategorys")
    List<PromotionEntity> getAllPromotion();

    @Query("Select pro From PromotionEntity pro "
            + "Join fetch pro.roomCategorys "
            + "where pro.id = ?1 ")
    PromotionEntity findPromotionById(int promotionId);

    @Query(value = "SELECT p FROM PromotionEntity p " + "Join fetch p.roomCategorys rc "
            + "Where p.id = ?1 ")
    PromotionEntity findOnePromotion(int promotionId);

    @Query("Select distinct pro From PromotionEntity pro "
            + "Join fetch pro.roomCategorys c "
            + "Where pro.name Like ?1 or "
            + "pro.status Like ?2 or "
            + "c.name Like ?3 ")
    List<PromotionEntity> findByNameLikeOrStatusLikeOrCategoryLike(String name, String status, String categoryName);

    //
    @Query(value = "SELECT p FROM PromotionEntity p " + "Join fetch p.roomCategorys rc "
            + "Where (( ?1 Between p.startDate And p.endDate ) and rc.id = ?2 )")
    List<PromotionEntity> findPromotions(Date startDate, int categoryId);

    @Query(value = "SELECT p.* FROM promotions p " + "Join category_promotion_relataion cat_pro on cat_pro.promotions_id = p.id "
            + "Join category rc on rc.id = cat_pro.category_id "
            + "Where (( ?1 Between p.startDate And p.endDate ) and rc.id = ?2 )", nativeQuery = true)
    List<PromotionEntity> findPromotionNative(Date startDate, int categoryId);

    @Query(value = "Select pe From PromotionEntity pe " + "Join fetch pe.roomCategorys rc " + "Where rc.id = ?1 ")
    PromotionEntity findPromotion(int categoryId);

    @Query(value = "SELECT p FROM PromotionEntity p " + "Join fetch p.roomCategorys rc "
            + "Where p.startDate > ?1 "
            + "Order By p.startDate ASC")
    List<PromotionEntity> findPromotions(Date nowDate);

}
