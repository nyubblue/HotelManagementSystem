package com.mycompany.jv30_hotel.domain;

/**
 *
 * @author buynl
 */
public class InvoiceItem {
    private String room_numer;
    private String services;
    private String price;
    private String room_type;

    public String getRoom_type() {
        return room_type;
    }

    public void setRoom_type(String room_type) {
        this.room_type = room_type;
    }
    

    public String getRoom_numer() {
        return room_numer;
    }

    public void setRoom_numer(String room_numer) {
        this.room_numer = room_numer;
    }

    public String getServices() {
        return services;
    }

    public void setServices(String services) {
        this.services = services;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
    
}
