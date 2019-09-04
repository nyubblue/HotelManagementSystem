/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.PromotionEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.service.CategoryService;
import com.mycompany.jv30_hotel.service.ImageService;
import com.mycompany.jv30_hotel.service.PromotionService;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/manager")
public class PromotionController {

    @Autowired
    private PromotionService promotionService;
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ImageService imageService;

    @RequestMapping("/listPromotion")
    public String viewPromotion(Model model, @RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
//        model.addAttribute("promotion", promotionService.getAllPromotion());
        List<PromotionEntity> promotionEntitys = promotionService.getAllPromotion();
        for (PromotionEntity promotionEntity : promotionEntitys) {
            List<RoomCategory> categorys = promotionEntity.getRoomCategorys();
            for (RoomCategory category : categorys) {
                category.setImageEntities(imageService.findByRoomCategory(category));
            }
//            model.addAttribute("category", categorys);
        }
        model.addAttribute("promotion", promotionEntitys);

        return "manager/view-list-promotion";
    }

    @RequestMapping("/form-add-promotion")
    public String addPromotionForm(Model model) {
        model.addAttribute("category", categoryService.getCategories());
        model.addAttribute("promotion", new PromotionEntity());
        model.addAttribute("action", "add_promotion");
        return "manager/form-add-promotion";
    }

    @RequestMapping(value = "/add_promotion",
            method = RequestMethod.POST)
    public String addPromotion(Model model,
            @Valid @ModelAttribute("promotion") PromotionEntity promotionEntity, BindingResult result) {
        if (result.hasErrors()) {
            model.addAttribute("category", categoryService.getCategories());
            return "manager/form-add-promotion";
        } else {

//        List<RoomCategory> roomCategorys = promotionEntity.getRoomCategorys();
//        promotionEntity.setRoomCategorys(roomCategorys);
            promotionEntity = promotionService.savePromotion(promotionEntity);

            if (promotionEntity.getId() > 0) {
                return "redirect:/manager/listPromotion?messages=Add Promotion " + promotionEntity.getName() + "  is successful"
                        + "&status=success";
            } else {
                return "redirect:/manager/listPromotion?messages=Add Promotion " + promotionEntity.getName() + "   is fail"
                        + "&status=fail";
            }
        }
    }

    @RequestMapping("/update-promotion-form/{promotionId}")
    public String formUpdatePromotion(Model model, @PathVariable("promotionId") int promotionId) {
//        model.addAttribute("promotion", promotionService.findById(promotionId));
        PromotionEntity promotionEntity = promotionService.findById(promotionId);
//        List<RoomCategory> roomCategorys = categoryService.getCategories();
        promotionEntity.setRoomCategorys(promotionEntity.getRoomCategorys());
        model.addAttribute("action", "update-promotion");
        model.addAttribute("category", categoryService.getCategories());
        model.addAttribute("promotion", promotionEntity);
        return "manager/form-add-promotion";
    }

    @RequestMapping("/update-promotion")
    public String updatePromotion(Model model, @ModelAttribute("promotion") PromotionEntity promotionEntity) {
        PromotionEntity promotion = promotionService.savePromotion(promotionEntity);
        if (promotion.getId() > 0) {
            return "redirect:/manager/listPromotion?messages=Update Promotion " + promotionEntity.getName() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/manager/listPromotion?messages=Update Promotion " + promotionEntity.getName() + "  is fail"
                    + "&status=fail";
        }
    }

    @RequestMapping("/detail-promotion/{promotionId}")
    public String ViewDetailPromotion(Model model, @PathVariable("promotionId") int promotionId) {
        PromotionEntity promotionEntity = promotionService.findById(promotionId);
        List<RoomCategory> categorys = categoryService.findByPromotionId(promotionId);
        for (RoomCategory category : categorys) {
            category.setImageEntities(imageService.findByRoomCategory(category));
        }
        promotionEntity.setRoomCategorys(categorys);
        model.addAttribute("promotion", promotionEntity);
        model.addAttribute("categorys", categorys);

        return "manager/view-detail-promotion";
    }

    @RequestMapping("/active-promotion/{promotionId}")
    public String activeAccount(Model model,
            @PathVariable("promotionId") int promotionId) {
        PromotionEntity entity = promotionService.findById(promotionId);
        entity.setStatus("Available");
        entity = promotionService.savePromotion(entity);
        if (entity.getId() > 0) {
            model.addAttribute("name", entity.getName());
            model.addAttribute("messages", "Available Promotion " + entity.getName() + " successful");
            model.addAttribute("status", "success");
            return "redirect:/manager/listPromotion";
        } else {
            model.addAttribute("name", entity.getName());
            model.addAttribute("messages", "Sorry! Your Promotion is not Available");
            model.addAttribute("status", "fail");
            return "manager/listPromotion";
        }
    }

    @RequestMapping("/block-promotion/{promotionId}")
    public String blockAccount(Model model,
            @PathVariable("promotionId") int promotionId) {
        PromotionEntity entity = promotionService.findById(promotionId);
        entity.setStatus("UnAvailable");
        entity = promotionService.savePromotion(entity);
        if (entity.getId() > 0) {
            return "redirect:/manager/listPromotion?messages=UnAvailable Promotion " + entity.getName() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/manager/listPromotion?messages=UnAvailable Promotion " + entity.getName() + "  is fail"
                    + "&status=fail";
        }
    }

    @RequestMapping("/search-promotion")
    public String searchPromotion(Model model,
            @ModelAttribute("searchTxt") String searchTxt) {
        List<PromotionEntity> promotionEntitys = promotionService.searchPromotion(searchTxt);
        for (PromotionEntity promotionEntity : promotionEntitys) {
            List<RoomCategory> categorys = promotionEntity.getRoomCategorys();
            for (RoomCategory category : categorys) {
                category.setImageEntities(imageService.findByRoomCategory(category));
            }
        }
        model.addAttribute("promotion", promotionEntitys);

        return "manager/view-list-promotion";
    }

    @InitBinder
    protected void initBinder(WebDataBinder binder) throws Exception {
        binder.registerCustomEditor(List.class, "roomCategorys", new CustomCollectionEditor(List.class) {
            protected RoomCategory convertElement(Object element) {
                if (element instanceof String) {
                    String id = (String) element;
                    RoomCategory roomCategory = categoryService.findRoomCategoryById(Integer.parseInt(id));
                    return roomCategory;
                }
                return null;
            }
        });
    }
}
