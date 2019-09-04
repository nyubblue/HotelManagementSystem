/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.AccountRoleEntity;
import com.mycompany.jv30_hotel.enums.Gender;
import com.mycompany.jv30_hotel.service.AccountRoleService;
import com.mycompany.jv30_hotel.service.AccountService;
import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private AccountRoleService accountRoleService;

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping("/home")
    public String viewHome(Model model) {
        model.addAttribute("message", "Welcome Admin");
        return "admin/home";
    }

    @RequestMapping("/listAccount")
    public String viewListAccount(Model model, @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        List<AccountEntity> accountEntitys = accountService.getAccountWithRole();
        model.addAttribute("account", accountEntitys);
        return "admin/listAccount";
    }

    @RequestMapping("/form-add-account")
    public String formAddAccount(Model model, @RequestParam(value = "messages", required = false) String messages,
            @RequestParam(value = "status", required = false) String status) {
        model.addAttribute("messages", messages);
        model.addAttribute("status", status);
        model.addAttribute("roles", accountRoleService.getAccountRole());
        model.addAttribute("genders", Gender.values());
        model.addAttribute("account", new AccountEntity());
        model.addAttribute("action", "add_account");
        return "admin/form-add-account";
    }

    @RequestMapping(value = "/add_account",
            method = RequestMethod.POST)
    public String addAccount(Model model,
            @Valid @ModelAttribute("account") AccountEntity account, BindingResult result) {
        model.addAttribute("account", account);
        if (result.hasErrors()) {
            model.addAttribute("roles", accountRoleService.getAccountRole());
            model.addAttribute("genders", Gender.values());
            model.addAttribute("action", "add_account");
            return "admin/form-add-account";
        } else {
            account = accountService.save(account);
            SimpleMailMessage email = new SimpleMailMessage();
            email.setTo(account.getEmail());
            email.setSubject("Active Account Hotel");
            email.setText("Hello " + account.getFullName() + "!. "
                    + "Please Click a link:" + "http://localhost:8084/JV30_Hotel/admin/active/" + account.getId() + " to active your account");
            // sends the e-mail
            mailSender.send(email);
        }
        if (account.getId() > 0) {
            return "redirect:/admin/listAccount?messages=Add Account " + account.getFullName() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/admin/listAccount?messages=Add Account is fail"
                    + "&status=fail";
        }
    }

    @RequestMapping("/active/{accountId}")
    public String activeAccount(Model model,
            @PathVariable("accountId") int accountId) {
        AccountEntity account = accountService.findById(accountId);
        account.setStatus("Active");
        account = accountService.save(account);
        if (account.getId() > 0) {
            model.addAttribute("name", account.getFullName());
            model.addAttribute("messages", "Active account " + account.getFullName() + " successful");
            model.addAttribute("status", "success");
            return "redirect:/admin/listAccount";
        } else {
            model.addAttribute("name", account.getFullName());
            model.addAttribute("messages", "Sorry! Your Account is not activated");
            model.addAttribute("status", "fail");
            return "admin/verify-account";
        }
    }

    @RequestMapping("/block/{accountId}")
    public String blockAccount(Model model,
            @PathVariable("accountId") int accountId) {
        AccountEntity account = accountService.findById(accountId);
        account.setStatus("Block");
        account = accountService.save(account);
        if (account.getId() > 0 && account.getStatus().equalsIgnoreCase("Block")) {
            return "redirect:/admin/listAccount?messages=Block Account " + account.getFullName() + "  is successful"
                    + "&status=success";
        } else {
            return "redirect:/admin/listAccount?messages=Block Account " + account.getFullName() + "  is fail"
                    + "&status=fail";
        }
    }

    @RequestMapping("/update-account-form/{accountId}")
    public String formUpdateAccount(Model model,
            @PathVariable("accountId") int accountId) {
        model.addAttribute("roles", accountRoleService.getAccountRole());
        model.addAttribute("account", accountService.findById(accountId));
        model.addAttribute("genders", Gender.values());
        model.addAttribute("action", "update-account");
        return "admin/form-add-account";
    }

    @RequestMapping(value = {"/update-account"}, method = RequestMethod.POST)
    public String updateAccount(Model model, @ModelAttribute("account") AccountEntity account) {
        account = accountService.save(account);
        if (account.getId() > 0) {
            return "redirect:/admin/listAccount?messages=Update Account " + account.getFullName() + " is successful"
                    + "&status=success";
        } else {
            return "redirect:/admin/listAccount?messages=Update Account " + account.getFullName() + "  is fail"
                    + "&status=fail";
        }
    }

    @RequestMapping("/search")
    public String searchRoom(Model model,
            @ModelAttribute("searchTxt") String searchTxt) {
        model.addAttribute("account", accountService.searchAccount(searchTxt));
        return "admin/listAccount";
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
        return "admin/profile";
    }

    @InitBinder
    protected void initBinder(WebDataBinder binder) throws Exception {
        binder.registerCustomEditor(List.class, "accountRoles", new CustomCollectionEditor(List.class) {
            protected AccountRoleEntity convertElement(Object element) {
                if (element instanceof String) {
                    String id = (String) element;
                    AccountRoleEntity accountRole = accountRoleService.getAccountRoleById(Integer.parseInt(id));
                    return accountRole;
                }
                return null;
            }
        });
    }
}
