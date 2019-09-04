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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author AnhLe
 */
@Entity
@Table(name = "account")
public class AccountEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String email;
    @NotEmpty
    @NotNull
    private String password;
    private String address;
    @NotNull
    @NotEmpty
    private String fullName;
    private String status;
    private int voteHotel;

    @Enumerated(EnumType.STRING)
    private Gender gender = Gender.MALE;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date birhDate;

    @ManyToMany(cascade = CascadeType.MERGE,
            fetch = FetchType.LAZY)
    @JoinTable(name = "acc_role_relationship",
            joinColumns = @JoinColumn(name = "acc_id",
                    referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "acc_role_id",
                    referencedColumnName = "id"))
    private List<AccountRoleEntity> accountRoles;

    @OneToMany(mappedBy = "accountEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<NotificationEntity> notificationEntities;

    @OneToMany(mappedBy = "accountEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<CommentEntity> commentEntities;

    @OneToMany(mappedBy = "accountEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private List<CustomerInfoEntity> customerInfoEntities;

    public AccountEntity() {
    }

    public AccountEntity(int id, String email, String password, String address, String fullName, String status, int voteHotel, Date birhDate, List<AccountRoleEntity> accountRoles, List<NotificationEntity> notificationEntities, List<CommentEntity> commentEntities, List<CustomerInfoEntity> customerInfoEntities) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.address = address;
        this.fullName = fullName;
        this.status = status;
        this.voteHotel = voteHotel;
        this.birhDate = birhDate;
        this.accountRoles = accountRoles;
        this.notificationEntities = notificationEntities;
        this.commentEntities = commentEntities;
        this.customerInfoEntities = customerInfoEntities;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getVoteHotel() {
        return voteHotel;
    }

    public void setVoteHotel(int voteHotel) {
        this.voteHotel = voteHotel;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public Date getBirhDate() {
        return birhDate;
    }

    public void setBirhDate(Date birhDate) {
        this.birhDate = birhDate;
    }

    public List<NotificationEntity> getNotificationEntities() {
        return notificationEntities;
    }

    public void setNotificationEntities(List<NotificationEntity> notificationEntities) {
        this.notificationEntities = notificationEntities;
    }

    public List<CommentEntity> getCommentEntities() {
        return commentEntities;
    }

    public void setCommentEntities(List<CommentEntity> commentEntities) {
        this.commentEntities = commentEntities;
    }

    public List<CustomerInfoEntity> getCustomerInfoEntities() {
        return customerInfoEntities;
    }

    public void setCustomerInfoEntities(List<CustomerInfoEntity> customerInfoEntities) {
        this.customerInfoEntities = customerInfoEntities;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<AccountRoleEntity> getAccountRoles() {
        return accountRoles;
    }

    public void setAccountRoles(List<AccountRoleEntity> accountRoles) {
        this.accountRoles = accountRoles;
    }

}
