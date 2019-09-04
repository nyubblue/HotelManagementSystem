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
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "bookingDetail")
public class BookingDetailEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private double price;

    @ManyToOne
    @JoinColumn(name = "bookings_id")
    private BookingEntity bookingEntity;

    @ManyToOne
    @JoinColumn(name = "room_entity_id")
    private RoomEntity roomEntity;

    @ManyToMany(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinTable(name = "bookdetail_service_relation",
            joinColumns = @JoinColumn(name = "bookDetail_id",
                    referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "services_id",
                    referencedColumnName = "id"))
    private List<ServiceEntity> serviceEntities;

    @Transient
    private List<ServiceEntity> serviceShow;

    public List<ServiceEntity> getServiceShow() {
        return serviceShow;
    }

    public void setServiceShow(List<ServiceEntity> serviceShow) {
        this.serviceShow = serviceShow;
    }
    
    public BookingDetailEntity() {
    }

    public BookingDetailEntity(int id, double price, BookingEntity bookingEntity, RoomEntity roomEntity, List<ServiceEntity> serviceEntities) {
        this.id = id;
        this.price = price;
        this.bookingEntity = bookingEntity;
        this.roomEntity = roomEntity;
        this.serviceEntities = serviceEntities;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public BookingEntity getBookingEntity() {
        return bookingEntity;
    }

    public void setBookingEntity(BookingEntity bookingEntity) {
        this.bookingEntity = bookingEntity;
    }

    public RoomEntity getRoomEntity() {
        return roomEntity;
    }

    public void setRoomEntity(RoomEntity roomEntity) {
        this.roomEntity = roomEntity;
    }

    public List<ServiceEntity> getServiceEntities() {
        return serviceEntities;
    }

    public void setServiceEntities(List<ServiceEntity> serviceEntities) {
        this.serviceEntities = serviceEntities;
    }

}
