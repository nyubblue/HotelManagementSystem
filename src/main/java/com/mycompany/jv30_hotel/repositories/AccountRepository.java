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
 * @author AnhLe
 */
@Repository
public interface AccountRepository extends
        CrudRepository<AccountEntity, Integer> {

    AccountEntity findByEmailLikeAndPasswordLike(
            String email, String password);

    AccountEntity findByEmailLike(
            String email);

    @Query("Select acc From AccountEntity acc "
            + "Join fetch acc.accountRoles "
            + "Where acc.email Like ?1 and "
            + "acc.password Like ?2")
    AccountEntity findAccountByEmailAndPassword(
            String email, String password);

    @Query("Select acc From AccountEntity acc "
            + "Join fetch acc.accountRoles "
            + "order by acc.id desc")
    List<AccountEntity> getAllAccountWithRole();

    @Query("Select acc From AccountEntity acc "
            + "Join fetch acc.accountRoles "
            + "Where acc.email Like ?1 or "
            + "acc.fullName Like ?2 or "
            + "acc.status Like ?3 order by acc.id desc")
    List<AccountEntity> findByEmailLikeAndFullNameLikeAndStatusLike(String email, String fullName, String status);

    @Query("Select acc From AccountEntity acc "
            + "Join fetch acc.accountRoles "
            + "Where acc.email Like ?1")
    List<AccountEntity> findByStatus(String status);
}
