/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.repositories.ServiceRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class HotelService {

    @Autowired
    private ServiceRepository serviceRepository;

    public List<ServiceEntity> getServices() {
        return (List<ServiceEntity>) serviceRepository.findAll();
    }

    public ServiceEntity saveService(ServiceEntity serviceEntity) {
        return serviceRepository.save(serviceEntity);
    }

    public ServiceEntity findServiceEntitybyId(int id) {
        return serviceRepository.findOne(id);
    }
    
     public List<ServiceEntity> searchService(String searchTxt) {
        return serviceRepository.findServiceEntityByNameOrStatus(searchTxt, searchTxt);
    }

    public List<ServiceEntity> findByBookingDetail(BookingDetailEntity entity) {
        return serviceRepository.findByBookingDetailsEntities(entity);
    }

    public Boolean deleteService(int id) {
        serviceRepository.delete(id);
        return serviceRepository.exists(id);
    }
}
