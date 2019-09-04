/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.AccountRoleEntity;
import com.mycompany.jv30_hotel.repositories.AccountRoleRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class AccountRoleService {

    @Autowired
    private AccountRoleRepository accountRoleRepository;

    public List<AccountRoleEntity> getAccountRole() {
        return (List<AccountRoleEntity>) accountRoleRepository.findAll();
    }

    public AccountRoleEntity getAccountRoleById(int id) {
        AccountRoleEntity accountRole = accountRoleRepository.findOne(id);
        return accountRole != null ? accountRole : new AccountRoleEntity();
    }

    public List<AccountRoleEntity> findByAccount(AccountEntity account) {
        return accountRoleRepository.findByAccounts(account);
    }
}
