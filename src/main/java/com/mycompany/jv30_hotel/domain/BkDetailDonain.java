package com.mycompany.jv30_hotel.domain;

import java.util.List;

public class BkDetailDonain {
	private int categoryId;
	private int numOfRoom;
	private int roomId;
	private List<Integer> promotionIds;
	private List<Integer> serviceIds;
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public List<Integer> getPromotionIds() {
		return promotionIds;
	}
	public void setPromotionIds(List<Integer> promotionIds) {
		this.promotionIds = promotionIds;
	}
	public List<Integer> getServiceIds() {
		return serviceIds;
	}
	public void setServiceIds(List<Integer> serviceIds) {
		this.serviceIds = serviceIds;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public int getNumOfRoom() {
		return numOfRoom;
	}
	public void setNumOfRoom(int numOfRoom) {
		this.numOfRoom = numOfRoom;
	}
	
}
