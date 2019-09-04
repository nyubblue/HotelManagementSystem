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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "category")
public class RoomCategory implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotNull
    private String name;
    @NotNull
    private double price;
    private String description;
    private int sizeRoom;
    private int number_of_bed;
    private String convenience;
    private String status;
    @Transient
    private String[] descriptions;

    @Transient
    private String[] conveniences;

    @OneToMany(mappedBy = "roomCategory",
            fetch = FetchType.LAZY,
            cascade = CascadeType.REMOVE)
    private List<RoomEntity> roomEntities;

    @OneToMany(mappedBy = "roomCategory",
            fetch = FetchType.LAZY,
            cascade = CascadeType.REMOVE)
    private List<ImageEntity> imageEntities;

//    @ManyToMany(cascade = {CascadeType.PERSIST,
//        CascadeType.MERGE}, fetch = FetchType.LAZY)
//    @JoinTable(name = "category_promotion_relataion",
//            joinColumns = @JoinColumn(name = "promotions_id",
//                    referencedColumnName = "id"),
//            inverseJoinColumns = @JoinColumn(
//                    name = "category_id",
//                    referencedColumnName = "id"))
//    private List<PromotionEntity> promotionEntities;
    @ManyToMany(mappedBy = "roomCategorys")
    private List<PromotionEntity> promotionEntities;

    public RoomCategory() {
    }

    public RoomCategory(int id, String name, double price, String description, int size, int number_of_bed, String convenience, String status, List<RoomEntity> roomEntities, List<ImageEntity> imageEntities, List<PromotionEntity> promotionEntities) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.sizeRoom = size;
        this.number_of_bed = number_of_bed;
        this.convenience = convenience;
        this.status = status;
        this.roomEntities = roomEntities;
        this.imageEntities = imageEntities;
//        this.promotionEntities = promotionEntities;
    }

    public String[] getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String[] descriptions) {
        this.descriptions = descriptions;
    }

    public String[] getConveniences() {
        return conveniences;
    }

    public void setConveniences(String[] conveniences) {
        this.conveniences = conveniences;
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

    public int getSizeRoom() {
        return sizeRoom;
    }

    public void setSizeRoom(int sizeRoom) {
        this.sizeRoom = sizeRoom;
    }

    public int getNumber_of_bed() {
        return number_of_bed;
    }

    public void setNumber_of_bed(int number_of_bed) {
        this.number_of_bed = number_of_bed;
    }

    public String getConvenience() {
        return convenience;
    }

    public void setConvenience(String convenience) {
        this.convenience = convenience;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<RoomEntity> getRoomEntities() {
        return roomEntities;
    }

    public void setRoomEntities(List<RoomEntity> roomEntities) {
        this.roomEntities = roomEntities;
    }

    public List<ImageEntity> getImageEntities() {
        return imageEntities;
    }

    public void setImageEntities(List<ImageEntity> imageEntities) {
        this.imageEntities = imageEntities;
    }

    public List<PromotionEntity> getPromotionEntities() {
        return promotionEntities;
    }

    public void setPromotionEntities(List<PromotionEntity> promotionEntities) {
        this.promotionEntities = promotionEntities;
    }

}
