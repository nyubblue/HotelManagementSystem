/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.repositories;

import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author buynl
 */
@Repository
public interface CustomerRepository extends CrudRepository<CustomerInfoEntity, Integer> {

    @Query(value = "Select ci From CustomerInfoEntity ci "
            + "Join fetch ci.accountEntity acc "
            + "Where acc.id = ?1 And ci.id = ?2 ")
    CustomerInfoEntity findCustomer(int accountId, int customerId);

    @Query(value = "Select c From CustomerInfoEntity c "
            + "Join c.bookingEntities be "
            + "Where be.id = ?1 ")
    CustomerInfoEntity findCustomerByBookingId(int bookingId);
}
