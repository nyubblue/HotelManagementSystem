/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.entities;

import com.mycompany.jv30_hotel.enums.Gender;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "customer_info")
public class CustomerInfoEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotNull(message = "Fullname is Not Null !")
    @Size(min = 3, max = 30, message = "Full Name can't be null ! ")
    private String fullName;
    @NotNull(message = "Not Null !")
    @Email(message = "Format is invalid !")
    private String email;
    @Size(min = 9 , max = 9, message = "ID Card must be 9 characters !")
    @NotNull(message = "Not Null")
    @NotEmpty(message = "Not Empty")
    private String idCard;
    private String address;
    @NotNull(message = "Phone is not null !")
     @Size(min = 10 , max = 10, message = "Phone must be 10 characters !")
    private String phone;
   
    @NotNull(message = "Date is not Null !")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date birthDate;

    @Enumerated(EnumType.STRING)
    private Gender gender = Gender.MALE;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private AccountEntity accountEntity;

    @OneToMany(mappedBy = "customerInfoEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<BookingEntity> bookingEntities;

    public CustomerInfoEntity() {
    }

    public CustomerInfoEntity(int id, String fullName, String email, String idCard, String address, String phone,
            Date birthDate, AccountEntity accountEntity, List<BookingEntity> bookingEntities) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.idCard = idCard;
        this.address = address;
        this.phone = phone;
        this.birthDate = birthDate;
        this.accountEntity = accountEntity;
        this.bookingEntities = bookingEntities;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public AccountEntity getAccountEntity() {
        return accountEntity;
    }

    public void setAccountEntity(AccountEntity accountEntity) {
        this.accountEntity = accountEntity;
    }

    public List<BookingEntity> getBookingEntities() {
        return bookingEntities;
    }

    public void setBookingEntities(List<BookingEntity> bookingEntities) {
        this.bookingEntities = bookingEntities;
    }

}
