package com.mycompany.jv30_hotel.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;

/**
 *
 * @author buynl
 */
public class Formatter {

    public static String pattern = "yyyy-MM-dd";
    private static SimpleDateFormat inSDF = new SimpleDateFormat("mm/dd/yyyy");
    private static SimpleDateFormat outSDF = new SimpleDateFormat("yyyy-mm-dd");

    public String formatDateNow() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(new Date());
    }

    public String formatDate(Date d) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(d);
    }
    public String formatDate(Date d, String pattern1){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern1);
        return simpleDateFormat.format(d);
    }

    public String convertLocalFormatDate(String inDate) {
        String outDate = "";
        if (inDate != null) {
            try {
                Date date = inSDF.parse(inDate);
                outDate = outSDF.format(date);
            } catch (ParseException ex) {
            }
        }
        return outDate;
    }

    public Date covertPatern(Date date) throws ParseException {
        String inDate = formatDate(date);
        SimpleDateFormat sDF = new SimpleDateFormat(pattern);

        return sDF.parse(inDate);

    }

    public int countDate(Date StartDate, Date endDate) {
        LocalDate date1 = LocalDate.parse(formatDate(StartDate));
        LocalDate date2 = LocalDate.parse(formatDate(endDate));
        Period period = Period.between(date1, date2);
        return period.getDays();
    }
}
