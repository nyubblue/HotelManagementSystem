/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.repositories.ImageRepository;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author HP
 */
@Service
public class ImageService {

    @Autowired
    private ImageRepository imageRepository;

    public ImageEntity saveImage(ImageEntity entity) {
        return imageRepository.save(entity);
    }

    public ImageEntity findById(int id) {
        return imageRepository.findOne(id);
    }

    public List<ImageEntity> listImages() {
        return (List<ImageEntity>) imageRepository.findAll();
    }

    public List<ImageEntity> findByCategoryId(int categoryId) {
        return imageRepository.findImageEntityByCategoryIdNative(categoryId);
    }

    public List<ImageEntity> findByServiceId(int serviceId) {
        return imageRepository.findImageEntityByServiceIdNative(serviceId);
    }

    public List<ImageEntity> findByRoomCategory(RoomCategory roomCategory) {
        return imageRepository.findByRoomCategory(roomCategory);
    }

    public List<ImageEntity> findByService(ServiceEntity entity) {
        return imageRepository.findByServiceEntity(entity);
    }
    
    public void deleteImage(int id){
    imageRepository.delete(id);
    }

    public List<ImageEntity> uploadImage(MultipartFile[] files, HttpServletRequest request) {
        List<ImageEntity> images = new ArrayList<>();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            try {
                byte[] bytes = file.getBytes();

                ServletContext context = request.getServletContext();
                String pathUrl = context.getRealPath("/images");

                int index = pathUrl.indexOf("target");
                String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources\\images\\";
                Path path = Paths.get(pathFolder + file.getOriginalFilename());
                Files.write(path, bytes);

                // get file name
                String name = file.getOriginalFilename();

                if (name == null) {
                    name = "new-image" + name;
                }

                ImageEntity image = new ImageEntity();
                image.setName(name);

                images.add(image);

            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return images;
    }
}
