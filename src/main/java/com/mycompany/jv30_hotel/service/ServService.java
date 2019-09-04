package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.repositories.ImageRepository;
import com.mycompany.jv30_hotel.repositories.ServiceRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author buynl
 */
@Service
public class ServService {

    @Autowired
    private ServiceRepository serviceRepository;
    @Autowired
    private ImageRepository imageRepository;

    public ServiceEntity getServiceById(int id) {
        ServiceEntity service = serviceRepository.findOne(id);
        return service != null ? service : new ServiceEntity();
    }

    public List<ServiceEntity> getAvailableServices() {
        return serviceRepository.findServices();
    }

}
