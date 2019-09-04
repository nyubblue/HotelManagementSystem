package com.mycompany.jv30_hotel.domain;

import com.mycompany.jv30_hotel.entities.ServiceEntity;
import java.util.ArrayList;
import java.util.List;

public class ServicesWrapper {

    List<ServiceEntity> sericesList = new ArrayList<ServiceEntity>();

    public ServicesWrapper() {
        // TODO Auto-generated constructor stub
    }

    public List<ServiceEntity> getSericesList() {
        return sericesList;
    }

    public void setSericesList(List<ServiceEntity> sericesList) {
        this.sericesList = sericesList;
    }

}
