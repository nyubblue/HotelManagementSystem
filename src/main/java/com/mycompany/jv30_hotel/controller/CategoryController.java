/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.service.CategoryService;
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
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ImageService imageService;

    @RequestMapping("/listCategory")
    public String viewCategoryRoom(Model model, @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        List<RoomCategory> categorys = categoryService.getCategories();
        for (RoomCategory category : categorys) {
            category.setImageEntities(imageService.findByRoomCategory(category));
        }
        model.addAttribute("category", categorys);
        return "manager/viewCategory";
    }

    @RequestMapping("/category")
    public String viewFormAddCategory(Model model, @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("category", new RoomCategory());
        model.addAttribute("action", "add_category");
        return "manager/form-add-category";
    }

    @RequestMapping(value = "/add_category",
            method = RequestMethod.POST)
    public String addCategory(Model model,
            @ModelAttribute("category") RoomCategory category,
            @RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
        if (category != null) {
            if (files != null && files.length > 0) {
                category.setImageEntities(imageService.uploadImage(files, request));
                category = categoryService.saveCategory(category);
                if (category.getId() > 0) {
                    if (category.getImageEntities().size() > 0) {
                        for (ImageEntity entity : category.getImageEntities()) {
                            entity.setRoomCategory(category);
                            imageService.saveImage(entity);
                        }
                    }
                    model.addAttribute("messages", "Add Room Category " + category.getName() + " successfully.");
                    model.addAttribute("status", "success");
                } else {
                    model.addAttribute("messages", "Add Room Category fail");
                    model.addAttribute("status", "fail");
                }
            }
        }
        return "redirect:/manager/listCategory";
    }

    @RequestMapping("/update-form-category/{categoryId}")
    public String formUpdateRoomCategory(Model model, @PathVariable("categoryId") int categoryId,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        RoomCategory category = categoryService.findRoomCategoryById(categoryId);
        category.setImageEntities(imageService.findByRoomCategory(category));
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("category", category);
        model.addAttribute("action", "update-category");
        return "manager/form-add-category";
    }

    @RequestMapping("/update-category")
    public String updateCategory(Model model, @ModelAttribute("category") RoomCategory category,
            @RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
//        category = categoryService.saveCategory(category);
        if (category != null) {
            if (files != null && files.length > 0) {
                category = categoryService.saveCategory(category);
                category.setImageEntities(imageService.uploadImage(files, request));
                if (category.getId() > 0) {
                    if (category.getImageEntities().size() > 0) {
                        for (ImageEntity entity : category.getImageEntities()) {
                            entity.setRoomCategory(category);
                            imageService.saveImage(entity);
                        }
                    }
                    model.addAttribute("messages", "Update Room Category " + category.getName() + "  successfully.");
                    model.addAttribute("status", "success");
                } else {
                    model.addAttribute("messages", "Update Room " + category.getName() + "  Category fail");
                    model.addAttribute("status", "fail");
                }
            }
        }
        return "redirect:/manager/listCategory";
    }

    @RequestMapping("/removeImg/{categoryId}/{imageId}")
    public String removeImage(Model model,
            @PathVariable("categoryId") int categoryId, @PathVariable("imageId") int imageId) {
        RoomCategory category = categoryService.findRoomCategoryById(categoryId);
        if (category.getId() > 0) {
            imageService.deleteImage(imageId);
            model.addAttribute("messages", "Image is removed successfully!");
            model.addAttribute("status", "success");
        } else {
            model.addAttribute("messages", "Image is removed fail");
            model.addAttribute("status", "fail");
        }
        return "redirect:/manager/update-form-category/" + categoryId;
    }

    @RequestMapping("/detail-category/{categoryId}")
    public String viewDetailCategory(Model model, @PathVariable("categoryId") int categoryId,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        RoomCategory roomCategory = categoryService.findRoomCategoryById(categoryId);
        List<ImageEntity> imageEntitys = imageService.findByCategoryId(categoryId);
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("category", roomCategory);
        model.addAttribute("images", imageEntitys);
        return "manager/view-detail-category";
    }

    @RequestMapping(value = "/searchCategory", method = RequestMethod.POST)
    public String searchCategory(Model model,
            @ModelAttribute("searchTxt") String searchTxt) {
        List<RoomCategory> categorys = categoryService.searchCategory(searchTxt);
        for (RoomCategory category : categorys) {
            category.setImageEntities(imageService.findByRoomCategory(category));
        }
        model.addAttribute("category", categorys);
        return "manager/viewCategory";
    }

    @RequestMapping("/active-category/{categoryId}")
    public String activeAccount(Model model,
            @PathVariable("categoryId") int categoryId) {
        RoomCategory roomEntity = categoryService.findRoomCategoryById(categoryId);
        roomEntity.setStatus("Available");
        roomEntity = categoryService.saveCategory(roomEntity);
        if (roomEntity.getId() > 0) {
            model.addAttribute("name", roomEntity.getName());
            model.addAttribute("messages", "Available Room Category " + roomEntity.getName() + " successful");
            model.addAttribute("status", "success");
            return "redirect:/manager/detail-category/" + roomEntity.getId();
        } else {
            model.addAttribute("name", roomEntity.getName());
            model.addAttribute("messages", "Sorry! Your Room Category is not Available");
            model.addAttribute("status", "fail");
            return "redirect:/manager/detail-category/" + roomEntity.getId();
        }
    }

    @RequestMapping("/block-category/{categoryId}")
    public String blockAccount(Model model,
            @PathVariable("categoryId") int categoryId) {
        RoomCategory roomEntity = categoryService.findRoomCategoryById(categoryId);
        roomEntity.setStatus("UnAvailable");
        roomEntity = categoryService.saveCategory(roomEntity);
        if (roomEntity.getId() > 0) {
            return "redirect:/manager/detail-category/" + roomEntity.getId() + "?messages=UnAvailable Room Category " + roomEntity.getName() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/manager/detail-category/" + roomEntity.getId() + "?messages=UnAvailable Room Category " + roomEntity.getName() + "  is fail"
                    + "&status=fail";
        }
    }

}
