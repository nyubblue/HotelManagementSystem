/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.ImageEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.enums.Gender;
import com.mycompany.jv30_hotel.service.AccountService;
import com.mycompany.jv30_hotel.service.CategoryService;
import com.mycompany.jv30_hotel.service.ImageService;
import com.mycompany.jv30_hotel.service.RoomService;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private RoomService roomService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private AccountService accountService;

    @RequestMapping("/home")
    public String viewHome(Model model) {
        model.addAttribute("message", "Welcome Manager");
        return "manager/home";
    }

    @RequestMapping("/standard")
    public String viewStandardRoom(Model model, @RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("room", roomService.getRoomSortDate());
        return "manager/standardRoom";
    }

    @RequestMapping("/form-add-room")
    public String addRoomForm(Model model) {
        model.addAttribute("category", categoryService.getCategories());
        RoomEntity room = new RoomEntity();
        model.addAttribute("room", room);
        model.addAttribute("action", "add_room");
        return "manager/form-add-room";
    }

    @RequestMapping(value = "/add_room",
            method = RequestMethod.POST)
    public String addRoom(Model model,
            @Valid @ModelAttribute("room") RoomEntity room, BindingResult result) {
        if (result.hasErrors()) {
            model.addAttribute("category", categoryService.getCategories());
            model.addAttribute("action", "add_room");
            return "manager/form-add-room";
        } else {
            room = roomService.saveRoom(room);
            if (room.getId() > 0) {
                return "redirect:/manager/standard?messages=Add Room " + room.getRoom_number() + " is successful"
                        + "&status=success";
            } else {
                return "redirect:/manager/standard?messages=Add Room is fail"
                        + "&status=fail";
            }
        }
    }

    @RequestMapping("/search")
    public String searchRoom(Model model,
            @ModelAttribute("searchTxt") String searchTxt) {
        model.addAttribute("room", roomService.searchRoomEntity(searchTxt));
        return "manager/standardRoom";
    }

    @RequestMapping("/update-form/{roomId}")
    public String formUpdateRoom(Model model, @PathVariable("roomId") int roomId) {
        model.addAttribute("category", categoryService.getCategories());
        RoomEntity room = roomService.findRoomEntityById(roomId);
        model.addAttribute("room", room);
        model.addAttribute("action", "update-room");
        return "manager/form-add-room";
    }

    @RequestMapping("/update-room")
    public String updateRoom(Model model, @ModelAttribute("room") RoomEntity roomEntity) {
        RoomEntity entity = roomService.saveRoom(roomEntity);
        if (entity.getId() > 0) {
            return "redirect:/manager/standard?messages=Update Room " + entity.getRoom_number() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/manager/standard?messages=Update Room is fail"
                    + "&status=fail";
        }
    }

    @RequestMapping("/detail/{roomId}")
    public String ViewDetailRoom(Model model, @PathVariable("roomId") int roomId) {
        RoomEntity room = roomService.findRoomEntityById(roomId);
        RoomCategory category = room.getRoomCategory();
        List<ImageEntity> images = imageService.findByCategoryId(category.getId());
        model.addAttribute("room", room);
        model.addAttribute("images", images);
        return "manager/view-detail";
    }

    @RequestMapping(value = "update-status-room/{roomId}", method = RequestMethod.POST)
    public String updateStatus(Model model,
            @RequestParam(value = "status") String status,
            @PathVariable("roomId") int roomId) {

        RoomEntity roomEntity = roomService.findRoomEntityById(roomId);

        switch (status) {
            case "yes":
                roomEntity.setStatus("Available");
                roomService.saveRoom(roomEntity);
                break;
            case "no":
                roomEntity.setStatus("UnAvailable");
                roomService.saveRoom(roomEntity);
                break;
        }

        return "redirect:/manager/standard?messages=Update status "
                + roomEntity.getStatus() + " for " + roomEntity.getRoom_number() + "  is successful"
                + "&status=success";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String showProfile(Model m, @RequestParam(required = false) String message) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity account = (AccountEntity) authentication.getPrincipal();
        if (account != null) {
            m.addAttribute("account", account);
        }
        m.addAttribute("message", message);
        m.addAttribute("genders", Gender.values());
        return "manager/profile";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public String updateProfile(Model m, @ModelAttribute("account") AccountEntity account, RedirectAttributes rd) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity accountcc = (AccountEntity) authentication.getPrincipal();
        if (accountcc != null) {
            accountcc.setAddress(account.getAddress());
            Date birthday = account.getBirhDate();
            accountcc.setBirhDate(birthday);
            accountcc.setGender(account.getGender());
            accountcc.setFullName(account.getFullName());
            accountcc.setPassword(account.getPassword());
            accountcc = accountService.save(accountcc);
            rd.addAttribute("message", "Update is sucessfull !");
            m.addAttribute("account", accountcc);
            return "redirect:/manager/profile";
        }
        rd.addAttribute("message", "Update is failed !");
        return "redirect:/manager/profile";
    }

}
