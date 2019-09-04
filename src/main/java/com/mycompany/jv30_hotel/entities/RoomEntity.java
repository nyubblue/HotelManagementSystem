/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
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
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "rooms")
public class RoomEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotNull
    @NotEmpty
    private String room_number;
    @NotNull
    @NotEmpty
    private String status;

    @OneToMany(mappedBy = "roomEntity",
            fetch = FetchType.LAZY,
            cascade = CascadeType.REMOVE)
    private List<BookingDetailEntity> bookingDetailEntities;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private RoomCategory roomCategory;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date createAT;

    public RoomEntity() {
    }

    public RoomEntity(int id, String room_number, String status, List<BookingDetailEntity> bookingDetailEntities, RoomCategory roomCategory, Date createAT) {
        this.id = id;
        this.room_number = room_number;
        this.status = status;
        this.bookingDetailEntities = bookingDetailEntities;
        this.roomCategory = roomCategory;
        this.createAT = createAT;
    }

    public Date getCreateAT() {
        return createAT;
    }

    public void setCreateAT(Date createAT) {
        this.createAT = createAT;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoom_number() {
        return room_number;
    }

    public void setRoom_number(String room_number) {
        this.room_number = room_number;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<BookingDetailEntity> getBookingDetailEntities() {
        return bookingDetailEntities;
    }

    public void setBookingDetailEntities(List<BookingDetailEntity> bookingDetailEntities) {
        this.bookingDetailEntities = bookingDetailEntities;
    }

    public RoomCategory getRoomCategory() {
        return roomCategory;
    }

    public void setRoomCategory(RoomCategory roomCategory) {
        this.roomCategory = roomCategory;
    }

}
