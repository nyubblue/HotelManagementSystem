/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.jv30_hotel.controller;

import com.mycompany.jv30_hotel.domain.ObjectWrapper;
import com.mycompany.jv30_hotel.domain.SearchingFormDomain;
import com.mycompany.jv30_hotel.domain.ServiceDomain;
import com.mycompany.jv30_hotel.entities.AccountEntity;
import com.mycompany.jv30_hotel.entities.AccountRoleEntity;
import com.mycompany.jv30_hotel.entities.BookingDetailEntity;
import com.mycompany.jv30_hotel.entities.BookingEntity;
import com.mycompany.jv30_hotel.entities.CustomerInfoEntity;
import com.mycompany.jv30_hotel.entities.PromotionEntity;
import com.mycompany.jv30_hotel.entities.RoomCategory;
import com.mycompany.jv30_hotel.entities.RoomEntity;
import com.mycompany.jv30_hotel.entities.ServiceEntity;
import com.mycompany.jv30_hotel.enums.AccountRole;
import com.mycompany.jv30_hotel.enums.Gender;
import com.mycompany.jv30_hotel.repositories.PromotionRepository;
import com.mycompany.jv30_hotel.service.AccountRoleService;
import com.mycompany.jv30_hotel.service.AccountService;
import com.mycompany.jv30_hotel.service.BookingDetailService;
import com.mycompany.jv30_hotel.service.BookingService;
import com.mycompany.jv30_hotel.service.CategoryService;
import com.mycompany.jv30_hotel.service.PromotionService;
import com.mycompany.jv30_hotel.service.ServService;
import com.mycompany.jv30_hotel.utils.Formatter;
import com.mycompany.jv30_hotel.utils.MailChecker;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {

    @Autowired
    private BookingDetailService bookingDetailService;
    @Autowired
    private BookingService bookingService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private AccountService accountService;

    @Autowired
    private ServService servService;

    @Autowired
    private AccountRoleService accountRoleService;

    @Autowired
    private PromotionService promotionService;

    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String viewHome(Model model) {
        model.addAttribute("search_domain", new SearchingFormDomain());
        model.addAttribute("services", servService.getAvailableServices());
        model.addAttribute("categories", categoryService.getcategoryList());
        model.addAttribute("categoryList", categoryService.getViewedCategory());
        PromotionEntity promotion = promotionService.getPromotionForNow();
        if (promotion != null) {
            model.addAttribute("promotion", promotion);
        }
        return "home";
    }

    @RequestMapping("/login")
    public String viewLogin(Model model,
            @RequestParam(value = "isError", required = false) boolean isError, @RequestParam(value = "message", required = false) String message) {
        if (isError) {
            model.addAttribute("message", "Username or Password is invalid");
            return "login";
        }
        model.addAttribute("message", message);
        return "login";

    }

    @RequestMapping("/forget-password")
    public String forgetPassword(@RequestParam(value = "message", required = false) String message, Model model) {
        model.addAttribute("message", message);
        return "forget-password";
    }

    @RequestMapping(value = "/get-password", method = RequestMethod.POST)
    public String getPassword(@RequestParam("username") String username, Model model) {
        AccountEntity account = accountService.findAccountByEmail(username);
        if (account != null) {
            SimpleMailMessage email = new SimpleMailMessage();
            email.setTo(account.getEmail());
            email.setSubject("Password for " + account.getFullName());
            email.setText("Your Password is:  " + account.getPassword());
            // sends the e-mail
            mailSender.send(email);
            model.addAttribute("message", "The password has been sent to your email address: " + account.getEmail());
            return "redirect:/login";

        } else {
            model.addAttribute("message", "Your email address: " + username + " was not found!");
            return "redirect:/forget-password";
        }

    }
//buyn

    @RequestMapping(value = "/cancelBooking")
    public String cancelBooking(Model m, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        if (booking != null) {
            session.removeAttribute("booking");
            return "redirect:/home";
        }
        return "redirect:/home";
    }

    @RequestMapping(value = "/searchBooking")
    public String submitSearchBooking(Model m, @ModelAttribute("search_domain") SearchingFormDomain formDomain,
            HttpSession session) throws Exception {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        Date dat1 = null, dat2 = null;
        if (booking == null) {
            try {
                dat1 = new SimpleDateFormat("yyyy-MM-dd")
                        .parse((new Formatter()).convertLocalFormatDate(formDomain.getCheckIn()));
                dat2 = new SimpleDateFormat("yyyy-MM-dd")
                        .parse((new Formatter()).convertLocalFormatDate(formDomain.getCheckOut()));
            } catch (Exception e) {
                session.removeAttribute("booking");
                return "redirect:/home";
            }
        }
        int categoryId = formDomain.getRoomCategoryId();
        List<RoomEntity> rooms = null;
        if (categoryId == 0) {
            if (booking != null) {
                dat1 = booking.getCheck_in();
                dat2 = booking.getCheck_out();
            }
            rooms = bookingService.findRoomsByCategoryDateAndCategoryIds(dat1, dat2);
            if (booking != null) {
                for (BookingDetailEntity d : booking.getBookingDetailEntities()) {
                    for (int i = 0; i < rooms.size(); i++) {
                        if (d.getId() == rooms.get(i).getId()) {
                            rooms.remove(rooms.get(i));
                        }
                    }
                }
            }

        } else {
            if (booking != null) {
                dat1 = booking.getCheck_in();
                dat2 = booking.getCheck_out();
            }
            rooms = bookingService.findRoomsByCategoryDateAndCategoryId(dat1, dat2, formDomain.getRoomCategoryId());
            if (booking != null) {
                for (BookingDetailEntity d : booking.getBookingDetailEntities()) {
                    for (int i = 0; i < rooms.size(); i++) {
                        if (d.getId() == rooms.get(i).getId()) {
                            rooms.remove(rooms.get(i));
                        }
                    }
                }
            }
        }
        if (rooms != null) {
            session.setAttribute("rooms", rooms);
            session.setAttribute("services", bookingService.getServices());
            session.setAttribute("cmd", formDomain);
            return "redirect:/search_info";
        }
        return "redirect:/home";
    }

    @RequestMapping(value = "/search_info")
    public String viewSearchRooms(Model m, HttpSession session) {
        List<RoomEntity> rooms = (List<RoomEntity>) session.getAttribute("rooms");
        List<ServiceEntity> services = (List<ServiceEntity>) session.getAttribute("services");
        SearchingFormDomain cmd = (SearchingFormDomain) session.getAttribute("cmd");
        m.addAttribute("rooms", rooms);
        m.addAttribute("services", services);
        m.addAttribute("cmd", cmd);
        m.addAttribute("categoryList", categoryService.getViewedCategory());
        session.removeAttribute("rooms");
        session.removeAttribute("services");
        session.removeAttribute("cmd");
        return "view_rooms";
    }

    @RequestMapping(value = "/room_order", method = RequestMethod.POST)
    public String addBookingDetail(Model m, @ModelAttribute("wrapper") ObjectWrapper wrapper, HttpSession session)
            throws ParseException {
        int roomId = wrapper.getRoomId();
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        Date checkIn = null, checkOut = null;
        if (booking == null) {
            checkIn = new SimpleDateFormat("yyyy-MM-dd")
                    .parse((new Formatter()).convertLocalFormatDate(wrapper.getCheckIn()));
            checkOut = new SimpleDateFormat("yyyy-MM-dd")
                    .parse((new Formatter()).convertLocalFormatDate(wrapper.getCheckOut()));
        }
        if (booking != null) {
            List<BookingDetailEntity> bookingDetails = booking.getBookingDetailEntities();
            checkIn = booking.getCheck_in();
            checkOut = booking.getCheck_out();

            if (bookingDetails != null && bookingDetails.size() > 0) {
                BookingDetailEntity bookingDetail = new BookingDetailEntity();
                bookingDetail.setId(roomId);
                RoomEntity room = categoryService.findOneRoom(checkIn, roomId);
                bookingDetail.setRoomEntity(room);
                RoomCategory roomCategory = room.getRoomCategory();
                double temp = roomCategory.getPrice();
                Formatter formatter = new Formatter();
                int days = formatter.countDate(checkIn, checkOut) + 1;
                double price = days * temp;
                List<PromotionEntity> promotions = roomCategory.getPromotionEntities();
                if (promotions != null && promotions.size() > 0) {
                    Iterator<PromotionEntity> it = promotions.iterator();
                    PromotionEntity promotion = it.next();
                    if (promotion != null) {
                        price -= price * (promotion.getDiscount()) / 100;
                    }
                }
                bookingDetail.setPrice(price);
                bookingDetails.add(bookingDetail);
                booking.setBookingDetailEntities(bookingDetails);
                booking.setTotal_price(price + booking.getTotal_price());
                session.removeAttribute("booking");
                session.setAttribute("booking", booking);
                m.addAttribute("booking", "booking");
            } else {
                // khi xoa het listDetail
                BookingDetailEntity bookingDetail = new BookingDetailEntity();
                RoomEntity room = categoryService.findOneRoom(checkIn, roomId);
                bookingDetail.setRoomEntity(room);
                bookingDetail.setId(roomId);
                RoomCategory roomCategory = categoryService.findOneRoom(checkIn, roomId).getRoomCategory();
                double temp = roomCategory.getPrice();
                Formatter formatter = new Formatter();
                int days = formatter.countDate(checkIn, checkOut) + 1;
                double price = (days) * temp;
                List<PromotionEntity> promotions = roomCategory.getPromotionEntities();
                if (promotions != null && promotions.size() > 0) {
                    Iterator<PromotionEntity> it = promotions.iterator();
                    PromotionEntity promotion = it.next();
                    if (promotion != null) {
                        price -= price * (promotion.getDiscount()) / 100;
                    }
                }
                bookingDetail.setPrice(price);
                bookingDetails.add(bookingDetail);
                booking.setBookingDetailEntities(bookingDetails);
                booking.setTotal_price(booking.getTotal_price() + price);
                m.addAttribute("booking", "booking");
                session.setAttribute("booking", booking);
            }

        } else {

            booking = new BookingEntity();
            booking.setBooking_date(new Date());
            booking.setCheck_in(checkIn);
            booking.setCheck_out(checkOut);
            List<BookingDetailEntity> bookingDetails = new ArrayList<BookingDetailEntity>();
            BookingDetailEntity bookingDetail = new BookingDetailEntity();
            RoomEntity room = categoryService.findOneRoom(checkIn, roomId);
            bookingDetail.setRoomEntity(room);
            bookingDetail.setId(roomId);
            RoomCategory roomCategory = categoryService.findOneRoom(checkIn, roomId).getRoomCategory();
            Formatter formatter = new Formatter();
            int days = formatter.countDate(checkIn, checkOut) + 1;
            double price = (days) * roomCategory.getPrice();
            List<PromotionEntity> promotions = roomCategory.getPromotionEntities();
            if (promotions != null && promotions.size() > 0) {
                Iterator<PromotionEntity> it = promotions.iterator();
                PromotionEntity promotion = it.next();
                if (promotion != null) {
                    price -= price * (promotion.getDiscount()) / 100;
                }
            }
            bookingDetail.setPrice(price);
            bookingDetails.add(bookingDetail);
            booking.setBookingDetailEntities(bookingDetails);
            booking.setTotal_price(price);
            m.addAttribute("booking", "booking");
            session.setAttribute("booking", booking);
        }
        session.setAttribute("categoryId", wrapper.getCategoryId());
        return "redirect:/view_order";
    }

    @RequestMapping(value = "/view_order")
    public String viewOrder(Model m, HttpSession session) {
        m.addAttribute("services", bookingService.getServices());
        Integer categoryId = (Integer) session.getAttribute("categoryId");
        m.addAttribute("categoryId", categoryId);
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        if (booking != null) {
            m.addAttribute("booking", booking);
            m.addAttribute("categoryList", categoryService.getViewedCategory());
            return "booking_carts";
        }
        return "redirect:/home";
    }

    @RequestMapping(value = "/continue/{categoryId}")
    public String continueBooking(Model m, @PathVariable("categoryId") int categoryId, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        if (booking != null) {
            SearchingFormDomain formDomain = new SearchingFormDomain();
            String date1 = (new Formatter()).formatDate(booking.getCheck_in());
            String date2 = (new Formatter()).formatDate(booking.getCheck_out());
            formDomain.setCheckIn(date1);
            formDomain.setCheckOut(date2);
            formDomain.setRoomCategoryId(categoryId);
            m.addAttribute("search_domain", formDomain);
        }
        return "redirect:/searchBooking";
    }

    @RequestMapping(value = "/deleteOne/{roomId}")
    public String deleteBooking(Model m, @PathVariable("roomId") int roomId, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        if (booking != null) {
            List<BookingDetailEntity> bookingDetails = booking.getBookingDetailEntities();
            if (bookingDetails != null && bookingDetails.size() > 0) {
                BookingDetailEntity detail = null;
                Iterator<BookingDetailEntity> it = bookingDetails.iterator();
                while (it.hasNext()) {
                    detail = it.next();
                    if (detail.getId() == roomId) {
                        booking.setTotal_price(booking.getTotal_price() - detail.getPrice());
                        break;
                    }
                }
                bookingDetails.remove(detail);
                booking.setBookingDetailEntities(bookingDetails);
            }
            session.removeAttribute("booking");
            session.setAttribute("booking", booking);
        }
        return "redirect:/view_order";
    }

    @RequestMapping(value = "/addService", method = RequestMethod.POST)
    public String requireServices(Model m, @ModelAttribute("serviceForm") ServiceDomain service, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        if (booking != null) {
            List<BookingDetailEntity> bookingDetails = booking.getBookingDetailEntities();
            int roomId = service.getRoomId();
            int servId = service.getServId();
            if (bookingDetails != null && bookingDetails.size() > 0) {
                int index = 0;
                double price = 0;
                Iterator<BookingDetailEntity> it = bookingDetails.iterator();
                while (it.hasNext()) {
                    BookingDetailEntity detail = it.next();
                    if (roomId == detail.getId()) {
                        ServiceEntity serv = bookingService.getAService(servId);
                        price = serv.getPrice() + detail.getPrice();
                        index = bookingDetails.indexOf(detail);
                        break;
                    }
                }
                bookingDetails.get(index).setPrice(price);
                List<ServiceEntity> services = bookingDetails.get(index).getServiceEntities();
                if (services != null && services.size() > 0) {
                    ServiceEntity serv = bookingService.getAService(servId);
                    services.add(serv);
                    bookingDetails.get(index).setServiceEntities(services);
                    List<ServiceEntity> serviceShow = new ArrayList<>();
                    for (ServiceEntity s : bookingDetails.get(index).getServiceShow()) {
                        if (s.getId() != servId) {
                            serviceShow.add(s);
                        }
                    }
                    bookingDetails.get(index).setServiceShow(serviceShow);
                    booking.setBookingDetailEntities(bookingDetails);
                    double total = serv.getPrice() + booking.getTotal_price();
                    booking.setTotal_price(total);
                    session.removeAttribute("booking");
                    session.setAttribute("booking", booking);

                } else {
                    List<ServiceEntity> services1 = new ArrayList<ServiceEntity>();
                    ServiceEntity serv = bookingService.getAService(servId);
                    services1.add(serv);
                    bookingDetails.get(index).setServiceEntities(services1);
                    List<ServiceEntity> serviceShow = new ArrayList<>();
                    for (ServiceEntity s : bookingService.getServices()) {
                        if (s.getId() != servId) {
                            serviceShow.add(s);
                        }
                    }
                    bookingDetails.get(index).setServiceShow(serviceShow);
                    booking.setBookingDetailEntities(bookingDetails);
                    double total = serv.getPrice() + booking.getTotal_price();
                    booking.setTotal_price(total);
                    session.removeAttribute("booking");
                    session.setAttribute("booking", booking);
                }
            }
        }
        m.addAttribute("booking", booking);
        return "redirect:/view_order";
    }

    @RequestMapping(value = "/deleteServ/{servId}/{roomId}")
    public String deleteService(Model m, @PathVariable("servId") int servId,
            @PathVariable("roomId") int roomId, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("booking");
        if (booking != null) {
            List<BookingDetailEntity> bookingDetails = booking.getBookingDetailEntities();
            if (bookingDetails != null && bookingDetails.size() > 0) {
                int index = 0;
                for (int i = 0; i < bookingDetails.size(); i++) {
                    if (bookingDetails.get(i).getId() == roomId) {
                        index = i;
                    }
                }
                BookingDetailEntity bookingDetail = bookingDetails.get(index);
                List<ServiceEntity> services = bookingDetail.getServiceEntities();
                if (services != null) {
                    Iterator<ServiceEntity> it = services.iterator();
                    int servIndx = 0;
                    ServiceEntity s = null;
                    while (it.hasNext()) {
                        s = it.next();
                        if (s.getId() == servId) {
                            servIndx = services.indexOf(s);
                            break;
                        }
                    }
                    bookingDetails.get(index).getServiceEntities().remove(servIndx);
                    bookingDetails.get(index).getServiceShow().add(s);
                    double price = bookingDetails.get(index).getPrice();
                    bookingDetails.get(index).setPrice(price - s.getPrice());
                    double total = booking.getTotal_price();
                    booking.setTotal_price(total - s.getPrice());
                    booking.setBookingDetailEntities(bookingDetails);
                    session.removeAttribute("booking");
                    session.setAttribute("booking", booking);
                }
            }
        }
        return "redirect:/view_order";
    }

    @RequestMapping(value = "/customInfo")
    public String showCustomerInfo(Model m, HttpSession session) {
        CustomerInfoEntity customer = new CustomerInfoEntity();
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            AccountEntity account = (AccountEntity) authentication.getPrincipal();
            customer.setFullName(account.getFullName());
            customer.setAddress(account.getAddress());
            customer.setEmail(account.getEmail());
            customer.setBirthDate(account.getBirhDate());
            customer.setGender(account.getGender());
        } else {
            customer.setGender(Gender.MALE);
        }
        m.addAttribute("genders", Gender.values());
        m.addAttribute("customerInfo", customer);
        if ((BookingEntity) session.getAttribute("booking") != null) {
            return "custome_info";
        } else {
            return "redirect:/home";
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @RequestMapping(value = "/saveBooking")
    public String saveBooking(Model m, @ModelAttribute("customerInfo") @Valid CustomerInfoEntity customer, BindingResult result, HttpSession session) {
        BookingEntity bookingc = null;
       
            if (result.hasErrors()) {
                m.addAttribute("customerInfo", customer);
                m.addAttribute("genders", Gender.values());
                return "custome_info";
            }
            BookingEntity booking = (BookingEntity) session.getAttribute("booking");
            if (booking != null) {

                if (customer != null) {
                    booking.setStatus("ORDERED");
                    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                    if (!(authentication instanceof AnonymousAuthenticationToken)) {
                        AccountEntity account1 = (AccountEntity) authentication.getPrincipal();
                        if (account1 != null) {
                            customer.setAccountEntity(account1);
                        }
                    }
                    customer = bookingService.saveCustomerInfo(customer);
                    booking.setCustomerInfoEntity(customer);
                    bookingc = bookingService.saveBooking(booking);
                    if (bookingc.getId() > 0) {
                        List<BookingDetailEntity> bookingDetails = bookingc.getBookingDetailEntities();
                        Iterator<BookingDetailEntity> it = bookingDetails.iterator();
                        while (it.hasNext()) {
                            BookingDetailEntity detail = it.next();
                            detail.setId(0);
                            detail.setBookingEntity(bookingc);
                            bookingDetailService.saveBookingDetail(detail);
                        }
                    }
                }
                session.setAttribute("customerInfo", customer);
                return "redirect:/sendMail";
            }
     
        return "redirect:/terminal?message=your saving is failed !";
    }

    @RequestMapping(value = "/terminal")
    public String viewResult(@RequestParam String message, Model m, HttpSession session) {
        if (session.getAttribute("booking") != null) {
            session.removeAttribute("booking");
        }
        m.addAttribute("message", message);
        m.addAttribute("categoryList", categoryService.getViewedCategory());
        return "donebooking";
    }

    @InitBinder
    protected void initBinder(WebDataBinder binder) throws Exception {
        binder.registerCustomEditor(List.class, "serviceEntities", new CustomCollectionEditor(List.class) {
            @Override
            protected ServiceEntity convertElement(Object element) {
                if (element instanceof String) {
                    String id = (String) element;
                    ServiceEntity serviceEntity = servService.getServiceById(Integer.parseInt(id));
                    return serviceEntity;
                }
                return null;
            }
        });
    }

    @RequestMapping(value = "/register")
    public String viewFormRegister(Model m) {
        m.addAttribute("account", new AccountEntity());
        m.addAttribute("genders", Gender.values());
        return "form-register";
    }

    @RequestMapping(value = "/register_user", method = RequestMethod.POST)
    public String processRegister(@ModelAttribute("account") AccountEntity account, RedirectAttributes ra) {

        account.setStatus("NO_ACCTIVE");
        List<AccountRoleEntity> accountRoles = new ArrayList<AccountRoleEntity>();
        AccountRoleEntity role = accountRoleService.getAccountRoleById(3);
        accountRoles.add(role);
        account.setAccountRoles(accountRoles);
        account = accountService.save(account);
        if (account != null) {
            ra.addFlashAttribute("account", account);
            return "redirect:/sendMailActive";
        }
        return "redirect:/terminal?message=Your register is failed !";
    }

    @InitBinder
    protected void initBinder1(WebDataBinder binder) throws Exception {
        binder.registerCustomEditor(List.class, "accountRoles", new CustomCollectionEditor(List.class) {
            @Override
            protected AccountRoleEntity convertElement(Object element) {
                if (element instanceof String) {
                    String id = (String) element;
                    AccountRoleEntity accountRole = accountRoleService.getAccountRoleById(Integer.parseInt(id));
                    return accountRole;
                }
                return null;
            }
        });
    }

    @RequestMapping("/active/{accountId}")
    public String activeAccount(Model model, @PathVariable("accountId") int accountId) {

        AccountEntity account = accountService.findById(accountId);
        account.setStatus("Active");
        account = accountService.save(account);
        return "redirect:/terminal?message=Your account is active !";
    }

    @RequestMapping(value = "/clickCategory/{categoryId}", method = RequestMethod.GET)
    public String clickPanelCategory(@PathVariable("categoryId") int categoryId, Model m) {
        m.addAttribute("categoryId", (Integer) categoryId);
        return "get_date";
    }

    @RequestMapping("/about_us")
    public String aboutUs() {
        return "about";
    }

    @RequestMapping("/category")
    public String category(Model model) {
        model.addAttribute("search_domain", new SearchingFormDomain());
        model.addAttribute("services", servService.getAvailableServices());
        model.addAttribute("categories", categoryService.getAllCategoryList());
        model.addAttribute("categoryList", categoryService.getViewedCategory());
        return "category";
    }
}
