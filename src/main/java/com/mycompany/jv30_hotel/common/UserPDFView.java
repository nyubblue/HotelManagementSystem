/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.common;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.PdfWriter;
import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.view.document.AbstractPdfView;

/**
 *
 * @author HP
 */
public class UserPDFView extends AbstractPdfView {

    @Override
    protected void buildPdfDocument(Map<String, Object> model, Document dcmnt,
            PdfWriter writer, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        String[] colums = {"Booking Date", "Room Number", "Price Of Room", "Service", "Total_Price Service", "Total_Price Detail"};

        BookingEntity booking = (BookingEntity) model.get("bookingDetail");
        Table table = new Table(6);
//        table.setWidths(new float[]{60, 40});
        table.setWidth(100);
        table.setPadding(5);
        table.setBorder(Table.TOP);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        dcmnt.add(new Paragraph(new Chunk("Customer:" + booking.getCustomerInfoEntity().getFullName(),
                FontFactory.getFont(FontFactory.HELVETICA, 30))));
        dcmnt.add(new Paragraph(new Chunk("Check In: " + dateFormat.format(booking.getCheck_in()), FontFactory.getFont(FontFactory.HELVETICA, 15))));
        dcmnt.add(new Paragraph(new Chunk("Check Out: " + dateFormat.format(booking.getCheck_out()), FontFactory.getFont(FontFactory.HELVETICA, 15))));
        dcmnt.add(new Paragraph(new Chunk("Total Price: " + booking.getTotal_price(),
                FontFactory.getFont(FontFactory.HELVETICA, 20))));
        dcmnt.add(new Paragraph(new Chunk("Booking Details:",
                FontFactory.getFont(FontFactory.HELVETICA, 20))));
        for (int i = 0; i < colums.length; i++) {
            table.addCell(colums[i]);
        }
        for (BookingDetailEntity detailEntity : booking.getBookingDetailEntities()) {
            table.addCell(dateFormat.format(booking.getBooking_date()));
            table.addCell(detailEntity.getRoomEntity().getRoom_number());
            table.addCell(String.valueOf(detailEntity.getRoomEntity().getRoomCategory().getPrice()));
//            for (ServiceEntity serviceEntity : detailEntity.getServiceEntities()) {
//
//                table.addCell(serviceEntity.getName() +" - " + String.valueOf(serviceEntity.getPrice())+" ; " );
////                table.addCell(String.valueOf(serviceEntity.getPrice()));
//
//            }
            String service = "";
            double price = 0;
            for (int i = 0; i < detailEntity.getServiceEntities().size(); i++) {
                String s = detailEntity.getServiceEntities().get(i).getName() + ", ";
                service += s;
               price  += detailEntity.getServiceEntities().get(i).getPrice();
            }
            table.addCell(service);
            table.addCell(String.valueOf(price));

            table.addCell(String.valueOf(detailEntity.getPrice()));
        }
        dcmnt.add(table);
    }
}
