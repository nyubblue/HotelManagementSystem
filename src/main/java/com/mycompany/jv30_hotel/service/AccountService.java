/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.service;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.AccountRoleEntity;
import com.mycompany.jv30_hotel.repositories.AccountRepository;
import com.mycompany.jv30_hotel.repositories.AccountRoleRepository;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author HP
 */
@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;
      @Autowired
    private AccountRoleRepository accountRoleRepository;

    public AccountEntity
            findAccountByEmailAndPassword(String email, String password) {
        return accountRepository.findAccountByEmailAndPassword(email, password);
    }

    public AccountEntity
            findAccountByEmail(String email) {
        return accountRepository.findByEmailLike(email);
    }

    public AccountEntity save(AccountEntity account) {
        return accountRepository.save(account);
    }

    public List<AccountEntity> getAccounts() {
        List<AccountEntity> accountEntitys = (List<AccountEntity>) accountRepository.findAll();
        return accountEntitys;
    }

    public List<AccountEntity> getAccountWithRole() {
        return accountRepository.getAllAccountWithRole();
    }

    public AccountEntity findById(int id) {
        return accountRepository.findOne(id);
    }

    public List<AccountEntity> searchAccount(String searchTxt) {
        return (List<AccountEntity>) accountRepository.findByEmailLikeAndFullNameLikeAndStatusLike(searchTxt, searchTxt, searchTxt);
    }
    //
    public AccountEntity getAccountById(int id){
        AccountEntity account = accountRepository.findOne(id);
        List<AccountRoleEntity> accountRoles = accountRoleRepository.findAccountRoleEntity(id);
        List<AccountRoleEntity> list = new ArrayList<>();
        Iterator<AccountRoleEntity> it = list.iterator();
        while(it.hasNext()){
            AccountRoleEntity role = it.next();
            int roleId = role.getId();
            list.add(accountRoleRepository.findOne(id));
        }
        account.setAccountRoles(list);
        return account;
                
    }
}
