/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.repositories.CategoryRepository;
import com.mycompany.jv30_hotel.repositories.RoomRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class RoomService {

    @Autowired
    private RoomRepository roomRepository;
    @Autowired
    private CategoryRepository categoryRepository;

    public List<RoomEntity> getRoom() {
        return (List<RoomEntity>) roomRepository.findAll();
    }
    
     public List<RoomEntity> getRoomSortDate() {
        return (List<RoomEntity>) roomRepository.findRoomEntityOrderByCreateAT();
    }

    public RoomEntity saveRoom(RoomEntity roomEntity) {
        return roomRepository.save(roomEntity);

    }

    public List<RoomEntity> searchRoomEntity(String searchTxt) {
        return roomRepository.findRoomByCategoryOrNameOrStatus(searchTxt, searchTxt, searchTxt);
    }

    public RoomEntity findRoomEntityById(int id) {
        RoomEntity roomEntity = roomRepository.findOne(id);
        if (roomEntity == null) {
            return new RoomEntity();
        }
        return roomEntity;
    }

    public Boolean deleteRoom(int id) {
        roomRepository.delete(id);
        return roomRepository.exists(id);
    }

}
