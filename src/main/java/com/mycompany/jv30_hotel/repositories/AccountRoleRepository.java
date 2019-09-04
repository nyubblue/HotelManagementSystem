/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.AccountRoleEntity;
import java.io.Serializable;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author HP
 */
@Repository
public interface AccountRoleRepository extends CrudRepository<AccountRoleEntity, Integer> {

    public List<AccountRoleEntity> findByAccounts(AccountEntity account);

    @Query("Select role From AccountRoleEntity role "
            + "Join fetch role.accounts acc "
            + "Where acc.id = ?1")
    List<AccountRoleEntity> findAccountRoleEntity(int accountId);
}
