/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.utils;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

/**
 *
 * @author buynl
 */
public class MailChecker {
    public boolean validateMailAxists(String email){
        boolean isValid = false;
        try{
            InternetAddress internetAddress  = new InternetAddress(email);
            internetAddress.validate();
            isValid = true;
        }catch(AddressException e){
           // not thing
        }
        return isValid;
    }
}
