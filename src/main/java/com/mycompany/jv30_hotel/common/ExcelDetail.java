/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.common;

import com.mycompany.jv30_hotel.domain.InvoiceItem;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.web.servlet.view.document.AbstractExcelView;

/**
 *
 * @author buynl
 */
public class ExcelDetail extends AbstractExcelView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setHeader("Content-Disposition", "attachment; filename=\"my-file.xls\"");
        List<InvoiceItem> invoiceItems = (List<InvoiceItem>) model.get("invoiceItems");

        HSSFSheet sheet = workbook.createSheet("Booking Invoice");
        sheet.setDefaultColumnWidth(30);

        // create style for header cells
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontName("Arial");
        style.setFillForegroundColor(HSSFColor.BLUE.index);
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        font.setBold(true);
        font.setColor(HSSFColor.WHITE.index);
        style.setFont(font);
        font.setColor(IndexedColors.WHITE1.getIndex());

        // create header row
        HSSFRow header = sheet.createRow(0);
        header.createCell(0).setCellValue("Room Type");
        header.getCell(0).setCellStyle(style);
        header.createCell(1).setCellValue("Room Number");
        header.getCell(1).setCellStyle(style);
        header.createCell(2).setCellValue("Services");
        header.getCell(2).setCellStyle(style);
        header.createCell(3).setCellValue("Price");
        header.getCell(3).setCellStyle(style);

        // create data rows
        int rowCount = 1;
        for (InvoiceItem aItem : invoiceItems) {
            HSSFRow aRow = sheet.createRow(rowCount++);
            aRow.createCell(0).setCellValue(aItem.getRoom_type());
            aRow.createCell(1).setCellValue(aItem.getRoom_numer());
            aRow.createCell(2).setCellValue(aItem.getServices());
            aRow.createCell(3).setCellValue(aItem.getPrice());
        }

    }

}
