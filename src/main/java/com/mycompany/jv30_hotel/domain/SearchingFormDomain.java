package com.mycompany.jv30_hotel.domain;

/**
 *
 * @author buynl
 */
public class SearchingFormDomain {
    private String checkIn;
    private String checkOut;
    private int roomCategoryId;

    public SearchingFormDomain() {
    }

    public SearchingFormDomain(String checkIn, String checkOut, int roomCategoryId) {
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.roomCategoryId = roomCategoryId;
    }

    public String getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(String checkIn) {
        this.checkIn = checkIn;
    }

    public String getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(String checkOut) {
        this.checkOut = checkOut;
    }

    public int getRoomCategoryId() {
        return roomCategoryId;
    }

    public void setRoomCategoryId(int roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }
    
    
}
