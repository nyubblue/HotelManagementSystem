/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.service.HotelService;
import com.mycompany.jv30_hotel.service.ImageService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/manager")
public class ServiceController {

    @Autowired
    private HotelService hotelService;
    @Autowired
    private ImageService imageService;

    @RequestMapping("/listService")
    public String viewListService(Model model, @RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        List<ServiceEntity> serviceEntitys = hotelService.getServices();
        for (ServiceEntity service : serviceEntitys) {
            service.setImageEntities(imageService.findByService(service));
        }
        model.addAttribute("service", serviceEntitys);
        return "manager/view-list-service";
    }

    @RequestMapping("/form-add-service")
    public String viewFormAddService(Model model, @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("service", new ServiceEntity());
        model.addAttribute("action", "add_service");
        return "manager/form-add-service";
    }

    @RequestMapping(value = "/add_service",
            method = RequestMethod.POST)
    public String addService(Model model,
            @ModelAttribute("service") ServiceEntity serviceEntity,
            @RequestParam("file") MultipartFile[] files, HttpServletRequest request) {

        if (serviceEntity != null) {
            if (files != null && files.length > 0) {
                serviceEntity.setImageEntities(imageService.uploadImage(files, request));
                serviceEntity = hotelService.saveService(serviceEntity);
                if (serviceEntity.getId() > 0) {
                    if (serviceEntity.getImageEntities().size() > 0) {
                        for (ImageEntity imageEntity : serviceEntity.getImageEntities()) {
                            imageEntity.setServiceEntity(serviceEntity);
                            imageService.saveImage(imageEntity);
                        }
                    }
                    model.addAttribute("messages", "Add Service " + serviceEntity.getName() + "   successfully.");
                    model.addAttribute("status", "success");

                } else {
                    model.addAttribute("messages", "Add Service " + serviceEntity.getName() + "    Category fail.");
                    model.addAttribute("status", "fail");
                }
            }
        }
        return "redirect:/manager/listService";
    }

    @RequestMapping("/update-service-form/{serviceId}")
    public String formUpdateService(Model model,
            @PathVariable("serviceId") int serviceId,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        ServiceEntity serviceEntity = hotelService.findServiceEntitybyId(serviceId);
        serviceEntity.setImageEntities(imageService.findByService(serviceEntity));
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("service", serviceEntity);
        model.addAttribute("action", "update-service");
        return "manager/form-add-service";
    }

    @RequestMapping("/update-service")
    public String updateService(Model model, @ModelAttribute("service") ServiceEntity serviceEntity,
            @RequestParam("file") MultipartFile[] files, HttpServletRequest request) {

        if (serviceEntity != null) {
            if (files != null && files.length > 0) {
                serviceEntity = hotelService.saveService(serviceEntity);
                serviceEntity.setImageEntities(imageService.uploadImage(files, request));
                if (serviceEntity.getId() > 0) {
                    if (serviceEntity.getImageEntities().size() > 0) {
                        for (ImageEntity imageEntity : serviceEntity.getImageEntities()) {
                            imageEntity.setServiceEntity(serviceEntity);
                            imageService.saveImage(imageEntity);
                        }
                    }
                    model.addAttribute("messages", "Update Service " + serviceEntity.getName() + "    successfully.");
                    model.addAttribute("status", "success");
                } else {
                    model.addAttribute("messages", "Update Service " + serviceEntity.getName() + "    Category fail.");
                    model.addAttribute("status", "fail");
                }
            }
        }
        return "redirect:/manager/listService";

    }

    @RequestMapping("/removeImgService/{serviceId}/{imageId}")
    public String removeImage(Model model,
            @PathVariable("serviceId") int serviceId, @PathVariable("imageId") int imageId) {
        ServiceEntity serviceEntity = hotelService.findServiceEntitybyId(serviceId);
        if (serviceEntity.getId() > 0) {
            imageService.deleteImage(imageId);
            model.addAttribute("messages", "Image is removed successfully!");
            model.addAttribute("status", "success");
        } else {
            model.addAttribute("messages", "Image is removed fail");
            model.addAttribute("status", "fail");
        }
        return "redirect:/manager/update-service-form/" + serviceId;
    }

    @RequestMapping("/detail-service/{serviceId}")
    public String ViewDetailService(Model model, @PathVariable("serviceId") int serviceId,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        ServiceEntity serviceEntity = hotelService.findServiceEntitybyId(serviceId);
        List<ImageEntity> imageEntitys = imageService.findByServiceId(serviceId);
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("images", imageEntitys);
        model.addAttribute("service", serviceEntity);
        return "manager/view-detail-service";
    }

    @RequestMapping(value = "/searchService", method = RequestMethod.POST)
    public String searchService(Model model,
            @ModelAttribute("searchTxt") String searchTxt) {
        List<ServiceEntity> serviceEntitys = hotelService.searchService(searchTxt);
        for (ServiceEntity entity : serviceEntitys) {
            entity.setImageEntities(imageService.findByService(entity));
        }
        model.addAttribute("service", serviceEntitys);
        return "manager/view-list-service";
    }

    @RequestMapping("/active-service/{serviceId}")
    public String activeAccount(Model model,
            @PathVariable("serviceId") int serviceId) {
        ServiceEntity serviceEntity = hotelService.findServiceEntitybyId(serviceId);
        serviceEntity.setStatus("Available");
        serviceEntity = hotelService.saveService(serviceEntity);
        if (serviceEntity.getId() > 0) {
            model.addAttribute("name", serviceEntity.getName());
            model.addAttribute("messages", "Available Service " + serviceEntity.getName() + " successful");
            model.addAttribute("status", "success");
            return "redirect:/manager/detail-service/" + serviceEntity.getId();
        } else {
            model.addAttribute("name", serviceEntity.getName());
            model.addAttribute("messages", "Sorry! Your Service is not Available");
            model.addAttribute("status", "fail");
            return "redirect:/manager/detail-service/" + serviceEntity.getId();
        }
    }

    @RequestMapping("/block-service/{serviceId}")
    public String blockAccount(Model model,
            @PathVariable("serviceId") int serviceId) {
        ServiceEntity serviceEntity = hotelService.findServiceEntitybyId(serviceId);
        serviceEntity.setStatus("UnAvailable");
        serviceEntity = hotelService.saveService(serviceEntity);
        if (serviceEntity.getId() > 0) {
            return "redirect:/manager/detail-service/" + serviceEntity.getId() + "?messages=UnAvailable Service " + serviceEntity.getName() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/manager/detail-service/" + serviceEntity.getId() + "?messages=UnAvailable Service " + serviceEntity.getName() + "  is fail"
                    + "&status=fail";
        }
    }
}
