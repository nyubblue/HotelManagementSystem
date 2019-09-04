/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "services")
public class ServiceEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotNull
    private String name;
    @NotNull
    private double price;
    private String description;
    private String status;

    @OneToMany(mappedBy = "serviceEntity",
            fetch = FetchType.LAZY,
            cascade = CascadeType.REMOVE)
    private List<ImageEntity> imageEntities;

    @ManyToMany(mappedBy = "serviceEntities")
    private List<BookingDetailEntity> bookingDetailsEntities;

    public ServiceEntity() {
    }

    public ServiceEntity(int id, String name, double price, String description, String status, List<ImageEntity> imageEntities, List<BookingDetailEntity> bookingDetailsEntities) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.status = status;
        this.imageEntities = imageEntities;
        this.bookingDetailsEntities = bookingDetailsEntities;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<ImageEntity> getImageEntities() {
        return imageEntities;
    }

    public void setImageEntities(List<ImageEntity> imageEntities) {
        this.imageEntities = imageEntities;
    }

    public List<BookingDetailEntity> getBookingDetailsEntities() {
        return bookingDetailsEntities;
    }

    public void setBookingDetailsEntities(List<BookingDetailEntity> bookingDetailsEntities) {
        this.bookingDetailsEntities = bookingDetailsEntities;
    }

}
