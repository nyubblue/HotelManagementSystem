/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.AccountRoleEntity;
import com.mycompany.jv30_hotel.enums.AccountRole;
import java.util.List;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author HP
 */
@Controller
public class ManagementController {

    @RequestMapping("/management")

    public String displayManagementPage(Model model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (!(authentication instanceof AnonymousAuthenticationToken)) {

            AccountEntity account = (AccountEntity) authentication.getPrincipal();

            if (account instanceof AccountEntity) {

                List<AccountRoleEntity> roles = account.getAccountRoles();
                for (AccountRoleEntity acr : roles) {
                    if (acr.getRole().equals(AccountRole.ROLE_ADMIN)) {

                        return "admin/home";

                    } else if (acr.getRole().equals(AccountRole.ROLE_MANAGER)) {

                        return "manager/home";

                    } else if (acr.getRole().equals(AccountRole.ROLE_USER)) {

                        return "user/home";
                    } else if (acr.getRole().equals(AccountRole.ROLE_RECEPTION)) {

                        return "reception/home";
                    } else {

                        return "home";
                    }
                }
            }

        }
        return "home";
    }
}
