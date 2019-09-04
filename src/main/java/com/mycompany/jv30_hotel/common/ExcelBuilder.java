
package com.mycompany.jv30_hotel.common;

import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.service.BookingDetailService;
import com.mycompany.jv30_hotel.service.HotelService;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractExcelView;

/**
 *
 * @author AnhLe
 */
public class ExcelBuilder extends AbstractExcelView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook hssfw,
            HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        String[] colums = {"Booking Id", "Custommer Infor", "Booking Date", "Check_in", "Check_out", "Total_Price", "Status"};
        String[] detail = {"Custommer Infor", "Room name", "Room Price", "Check_in", "Check_out", "Services", "Price Service", "Total Price"};
        List<BookingEntity> bookingEntitys = (List<BookingEntity>) model.get("booking");
        // create a new Excel sheet
        HSSFSheet sheet = hssfw.createSheet("List Booking");
        sheet.setDefaultColumnWidth(20);

        // create style for header cells
        CellStyle style = hssfw.createCellStyle();
        Font font = hssfw.createFont();
        font.setFontName("Arial");
        style.setFillForegroundColor(HSSFColor.BLUE.index);
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        font.setBold(true);
        font.setColor(HSSFColor.WHITE.index);
        style.setFont(font);

        // Create Cell Style for formatting Date
        CreationHelper createHelper = hssfw.getCreationHelper();
        CellStyle dateCellStyle = hssfw.createCellStyle();
        dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-MM-yyyy"));
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

        // create header row
        HSSFRow header = sheet.createRow(0);
        for (int i = 0; i < colums.length; i++) {
            header.createCell(i).setCellValue(colums[i]);
            header.getCell(i).setCellStyle(style);
        }

        int rowCount = 1;
        for (BookingEntity booking : bookingEntitys) {

            HSSFRow aRow = sheet.createRow(rowCount++);
            aRow.createCell(0).setCellValue(rowCount - 1);

            aRow.createCell(1).setCellValue(booking.getCustomerInfoEntity().getFullName());
            aRow.createCell(2).setCellValue(dateFormat.format(booking.getBooking_date()));
            aRow.createCell(3).setCellValue(dateFormat.format(booking.getCheck_in()));
            aRow.createCell(4).setCellValue(dateFormat.format(booking.getCheck_out()));
            aRow.createCell(5).setCellValue(booking.getTotal_price());
            aRow.createCell(6).setCellValue(booking.getStatus());

            int rowCountdetail = 1;
            for (BookingDetailEntity detailEntity : booking.getBookingDetailEntities()) {
//                int bkdId = detailEntity.getId();
                HSSFSheet sheet1 = hssfw.createSheet("Booking Id " + booking.getId());
                sheet1.setDefaultColumnWidth(30);
                HSSFRow header1 = sheet1.createRow(0);
                for (int i = 0; i < detail.length; i++) {
                    header1.createCell(i).setCellValue(detail[i]);
                    header1.getCell(i).setCellStyle(style);
                }
                HSSFRow aRow1 = sheet1.createRow(rowCountdetail++);
                aRow1.createCell(0).setCellValue(booking.getCustomerInfoEntity().getFullName());
                aRow1.createCell(1).setCellValue(detailEntity.getRoomEntity().getRoom_number());
                aRow1.createCell(2).setCellValue(detailEntity.getRoomEntity().getRoomCategory().getPrice());
                aRow1.createCell(3).setCellValue(dateFormat.format(booking.getCheck_in()));
                aRow1.createCell(4).setCellValue(dateFormat.format(booking.getCheck_out()));
                for (ServiceEntity serviceEntity : detailEntity.getServiceEntities()) {
                    aRow1.createCell(5).setCellValue(serviceEntity.getName());
                    aRow1.createCell(6).setCellValue(serviceEntity.getPrice());
                }
                aRow1.createCell(7).setCellValue(detailEntity.getPrice());
            }

        }
    }

}
