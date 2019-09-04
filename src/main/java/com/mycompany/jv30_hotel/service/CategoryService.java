/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.PromotionEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.repositories.CategoryRepository;
import com.mycompany.jv30_hotel.repositories.ImageRepository;
import com.mycompany.jv30_hotel.repositories.PromotionRepository;
import com.mycompany.jv30_hotel.repositories.RoomRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private PromotionRepository promotionRepositoy;

    public List<RoomCategory> getCategories() {
        return (List<RoomCategory>) categoryRepository.findAll();
    }

    public RoomCategory saveCategory(RoomCategory category) {

        List<ImageEntity> entitys = category.getImageEntities();
        category.setImageEntities(entitys);
        return categoryRepository.save(category);
    }

    public RoomCategory findRoomCategoryById(int id) {
        RoomCategory category = categoryRepository.findOne(id);
        if (category == null) {
            return new RoomCategory();
        }
        return category;
    }

    public List<RoomCategory> findByPromotionId(int promotionId) {
        List<RoomCategory> categorys = categoryRepository.findByPromotionId(promotionId);
        if (categorys == null) {
            return new ArrayList<RoomCategory>();
        }
        return categorys;
    }

    public List<RoomCategory> searchCategory(String name) {
        return categoryRepository.findRoomCategoryByNameOrStatus(name, name);
    }

    public Boolean deleteCategory(int id) {
        categoryRepository.delete(id);
        return categoryRepository.exists(id);
    }

    //
    public RoomCategory findCategoryWithSubimages(int category_id) {
        RoomCategory category = categoryRepository.findOne(category_id);
        category.setImageEntities(imageRepository.findImage(category_id));
        category.setRoomEntities(roomRepository.findRooms(category.getId()));
        return category;
    }

    public List<RoomCategory> findRoomCategorys(Date checkIn, Date checkOut) {
        List<RoomCategory> list = (List<RoomCategory>) categoryRepository.findCategorys(checkIn, checkOut);
        for (RoomCategory category : list) {
            category.setImageEntities(imageRepository.findImage(category.getId()));
            if (category != null) {
                category.setDescriptions(category.getDescription().split(","));
                category.setConveniences(category.getConvenience().split(","));
            }
            category.setRoomEntities(roomRepository.findRooms(category.getId()));
        }
        return list;
    }

    public List<RoomEntity> getRooms() {
        return (List<RoomEntity>) roomRepository.findAll();
    }

    public RoomEntity findOneRoom(Date checkin, int roomId) {
        RoomEntity room = roomRepository.findOne(roomId);
        RoomCategory category = categoryRepository.findRoomCategory(roomId);
        if (category != null) {
            category.setDescriptions(category.getDescription().split(","));
            category.setConveniences(category.getConvenience().split(","));
        }
        category.setPromotionEntities(promotionRepositoy.findPromotionNative(checkin, category.getId()));
        room.setRoomCategory(category);
        return room;
    }

    public RoomCategory findOneCategory(int id) {
        return categoryRepository.findOne(id);
    }

    public RoomEntity save(RoomEntity room) {
        return roomRepository.save(room);
    }

    public RoomEntity findRoomById(int id) {
        return roomRepository.findOne(id);
    }

    public List<RoomCategory> getAllCategoryList() {
        List<RoomCategory> list = categoryRepository.findCategoriesAll();
        for (int i = 0; i < list.size(); i++) {
            list.get(i).setDescriptions(list.get(i).getDescription().split(","));
            List<ImageEntity> images = imageRepository.findImage(list.get(i).getId());
            list.get(i).setImageEntities(images);
        }
        return list;
    }

    public List<RoomCategory> getcategoryList() {
        List<RoomCategory> list = categoryRepository.findCategoriesPromotion(new Date());
        for (int i = 0; i < list.size(); i++) {
            List<ImageEntity> images = imageRepository.findImage(list.get(i).getId());
            list.get(i).setImageEntities(images);
        }
        return list;
    }

    public List<RoomCategory> getViewedCategory() {
        return categoryRepository.findViewedCategory();
    }
}
