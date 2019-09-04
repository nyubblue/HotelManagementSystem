/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.PromotionEntity;
import com.mycompany.jv30_hotel.repositories.PromotionRepository;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class PromotionService {

    @Autowired
    private PromotionRepository promotionRepository;

    public List<PromotionEntity> getPromotions() {
        return (List<PromotionEntity>) promotionRepository.findAll();
    }

    public List<PromotionEntity> getAllPromotion() {
        return promotionRepository.getAllPromotion();
    }

    public PromotionEntity savePromotion(PromotionEntity promotionEntity) {
        return promotionRepository.save(promotionEntity);
    }

    public PromotionEntity findById(int promotionId) {
        return promotionRepository.findOne(promotionId);
    }

    public List<PromotionEntity> searchPromotion(String searchTxt) {
        return promotionRepository.findByNameLikeOrStatusLikeOrCategoryLike(searchTxt, searchTxt, searchTxt);
    }

    //buyn add
    public PromotionEntity getPromotionForNow() {
        List<PromotionEntity> promotions = promotionRepository.findPromotions(new Date());
        PromotionEntity promotion = promotions.get(0);
        return promotion;
    }

//    public List<PromotionEntity> findbyCategory() {
//        return promotionRepository.findByRoomCategorys();
//    }
}
