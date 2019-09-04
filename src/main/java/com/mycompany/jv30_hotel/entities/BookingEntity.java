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
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "bookings")
public class BookingEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date booking_date;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date check_in;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date check_out;

    private double total_price;
    private String status;

    @ManyToOne
    @JoinColumn(name = "customer_info_id")
    private CustomerInfoEntity customerInfoEntity;

    @OneToMany(mappedBy = "bookingEntity",
            fetch = FetchType.LAZY,
            cascade = CascadeType.REMOVE)
    private List<BookingDetailEntity> bookingDetailEntities;

    public BookingEntity() {
    }

    public BookingEntity(int id, Date booking_date, Date check_in, Date check_out, double total_price, String status, CustomerInfoEntity customerInfoEntity, List<BookingDetailEntity> bookingDetailEntities) {
        this.id = id;
        this.booking_date = booking_date;
        this.check_in = check_in;
        this.check_out = check_out;
        this.total_price = total_price;
        this.status = status;
        this.customerInfoEntity = customerInfoEntity;
        this.bookingDetailEntities = bookingDetailEntities;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(Date booking_date) {
        this.booking_date = booking_date;
    }

    public Date getCheck_in() {
        return check_in;
    }

    public void setCheck_in(Date check_in) {
        this.check_in = check_in;
    }

    public Date getCheck_out() {
        return check_out;
    }

    public void setCheck_out(Date check_out) {
        this.check_out = check_out;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public CustomerInfoEntity getCustomerInfoEntity() {
        return customerInfoEntity;
    }

    public void setCustomerInfoEntity(CustomerInfoEntity customerInfoEntity) {
        this.customerInfoEntity = customerInfoEntity;
    }

    public List<BookingDetailEntity> getBookingDetailEntities() {
        return bookingDetailEntities;
    }

    public void setBookingDetailEntities(List<BookingDetailEntity> bookingDetailEntities) {
        this.bookingDetailEntities = bookingDetailEntities;
    }

}
