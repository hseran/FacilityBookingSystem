/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BookingDAO;
import dao.CustomerDAO;
import dao.FacilityDAO;
import dao.FacilityInstancesDAO;
import dao.UserQueryDAO;
import entity.Booking;
import entity.Customer;
import entity.Facility;
import entity.FacilityInstances;
import entity.UserQuery;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author naresh
 */
@WebServlet(name = "ControllerServlet",
        urlPatterns = {
    "/index",
    "/facility",
    "/checkIDAvailablility",
    "/register",
    "/login",
    "/logout",
    "/account",
    "/editProfile",
    "/contact",
    "/current-bookings",
    "/view",
    "/book",
    "/past-bookings",
    "/canceled-bookings",
    "/submit-query",
    "/cancel-booking",
    "/booking-details"
})
public class ControllerServlet extends HttpServlet {

    @EJB
    CustomerDAO customerDAO;
    @EJB
    BookingDAO bookingDAO;
    @EJB
    FacilityDAO facilityDAO;
    @EJB
    FacilityInstancesDAO facilityInstancesDAO;
    @EJB
    UserQueryDAO userQueryDAO;

    @Override
    public void init() throws ServletException {
        super.init();

        // store category list in servlet context. They are same for all users
        getServletContext().setAttribute("facilities", facilityDAO.findAll());
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        System.out.println(" in get " + userPath);
        Customer loggedInUser = (Customer) session.getAttribute("customer");

        if (userPath.equals("index")) {
            //do nothing
        } // if category page is requested
        else if (userPath.equals("/facility")) {

            // get categoryId from request
            String facilityId = request.getQueryString();
            if (facilityId != null && !facilityId.isEmpty()) {
                // get selected facility
                Facility selectedFacility =
                        facilityDAO.find(Integer.parseInt(facilityId));
                // place selected category in session scope
                session.setAttribute("selectedFacility", selectedFacility);
            }
        } else if (userPath.equals("/register")) {
            /*
             * just redirect user to register.jsp
             */
        } else if (userPath.equals("/login")) {
            /*
             * Just redirect user to index
             */
            response.sendRedirect("index");
            return;
        } else if (userPath.equals("/logout")) {
            /*
             * clear the session variable & redirect to index.jsp
             */
            session.removeAttribute("customer");
            response.sendRedirect("index");
            return;
        }
        else if (userPath.equals("/current-bookings")){
            /*
             * clear the session variable & redirect to index.jsp
             */
            if (loggedInUser == null)
            {
                response.sendRedirect("index");
                return;
            }
            request.setAttribute("bookings", 
                    bookingDAO.getCurrentBookings(loggedInUser.getId()));
        }
        else if (userPath.equals("/past-bookings")){
            /*
             * clear the session variable & redirect to index.jsp
             */
            if (loggedInUser == null)
            {
                response.sendRedirect("index");
                return;
            }
            request.setAttribute("bookings", 
                    bookingDAO.getPastBookings(loggedInUser.getId()));
        }
        else if (userPath.equals("/canceled-bookings")){
            /*
             * clear the session variable & redirect to index.jsp
             */
            if (loggedInUser == null)
            {
                response.sendRedirect("index");
                return;
            }
            request.setAttribute("bookings", 
                    bookingDAO.getCanceledBookings(loggedInUser.getId()));
        }
        else if (userPath.equals("/booking-details")){
            /*
             * clear the session variable & redirect to index.jsp
             */
            if (loggedInUser == null)
            {
                response.sendRedirect("index");
                return;
            }
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            request.setAttribute("booking", bookingDAO.find(bookingId));
        }
        // use RequestDispatcher to forward request
        String url = "jsp" + userPath + ".jsp";
        System.out.println(url);
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(
                    Level.SEVERE, null, ex);
        }

    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String userPath = request.getServletPath();

        HttpSession session = request.getSession();
        Customer loggedInUser = (Customer) session.getAttribute("customer");

        if (userPath.equals("/register")) {
            Customer newCustomer = readCustomerFromRegisterRequest(request);
            customerDAO.create(newCustomer);
            /*
             * direct user to login after registration
             */

            //session.setAttribute("customer", newCustomer);
            request.setAttribute("registrationMessage", true);
        }
        else if (userPath.equals("/cancel-booking")) {
            if (loggedInUser == null)
            {
                response.sendRedirect("index");
                return;
            }
            
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            Booking booking = bookingDAO.find(bookingId);
            booking.setIsCancelled(Boolean.TRUE);
            booking.setCancellationDate(new Date());
            bookingDAO.edit(booking); 
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }else if (userPath.equals("/checkIDAvailablility")) {
            /*
             * we check is the login ID is already in use by someone else
             */
            String login = request.getParameter("login");
            System.out.println(login);
            System.out.println("checking availability " + login);
            boolean available = customerDAO.isLoginIDAvailable(login);
            response.setContentType("text/plain");
            PrintWriter writer = response.getWriter();
            writer.print(available);
            return;
        }
        else if (userPath.equals("/view")) {

            List<Booking> l = null;
            String date = request.getParameter("datepicker");
            
            String fid = request.getParameter("fid");
            int facid = Integer.parseInt(fid);

            Facility selFacility = (Facility) session.getAttribute("selectedFacility");

            session.setAttribute("facility_instance_id", facid);
            request.setAttribute("selectedInstance", facilityInstancesDAO.find(facid));
            
            String[] status = new String[]{"Available", "Available", "Available", "Available", "Available",
                "Available", "Available", "Available", "Available", "Available", "Available"};
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy"); 
            Date convertedDate = null;
            try 
            { 
                convertedDate = dateFormat.parse(date);
            } 
            catch (ParseException ex) 
            {
                Logger.getLogger(ControllerServlet.class.getName()).log(
                        Level.SEVERE, null, ex);
                throw new ServletException("Incorrect Date Format");
            }
            
            session.setAttribute("isToday", isSameDay(convertedDate, new Date()));            
            session.setAttribute("selectdate", convertedDate);
            
            try {
                l = bookingDAO.getBookingByDate(convertedDate, facid);
            } catch (Exception e) {
                System.out.println("Exception seen " + e.getMessage());
            }
            
            if (l != null) {
                for (Booking b : l)
                {
                    int startTime = b.getBookingFrom();
                    if (startTime == 8) {
                        status[0] = "Unavailable";
                    } else if (startTime == 9) {
                        status[1] = "Unavailable";
                    } else if (startTime == 10) {
                        status[2] = "Unavailable";
                    } else if (startTime == 11) {
                        status[3] = "Unavailable";
                    } else if (startTime == 12) {
                        status[4] = "Unavailable";
                    } else if (startTime == 13) {
                        status[5] = "Unavilable";
                    } else if (startTime == 14) {
                        status[6] = "Unavailable";
                    } else if (startTime == 15) {
                        status[7] = "Unavailable";
                    } else if (startTime == 16) {
                        status[8] = "Unavailable";
                    } else if (startTime == 17) {
                        status[9] = "Unavailable";
                    } else if (startTime == 18) {
                        status[10] = "Unavailable";
                    }
                }
            }
            session.setAttribute("bookmap", status);
        } else if (userPath.equals("/book")) {
            
            if (loggedInUser == null)
            {
                response.sendRedirect("index");
                return;
            }
            
            int value, facility_instance_id;


            facility_instance_id = (Integer) session.getAttribute("facility_instance_id");
            String checkedId = request.getParameter("slot");

            FacilityInstances f = facilityInstancesDAO.find(facility_instance_id);

            Booking b = new Booking();
            b.setCustomerId(loggedInUser);
            b.setFacilityInstanceId(f);
            b.setCreatedDate(new Date());
            b.setIsCancelled(Boolean.FALSE);
            
            Date convertedDate = (Date)session.getAttribute("selectdate");
            b.setBookingDate(convertedDate);

            value = Integer.parseInt(checkedId);
            b.setBookingFrom(value);
            b.setBookingTo(value + 1);
            
            if (bookingDAO.checkMultipleFacilitiesAtSameTime(loggedInUser.getId(), value, convertedDate))
            {
                PrintWriter writer = response.getWriter();
                writer.write("You already have another booking on " + new SimpleDateFormat("yyyy-MM-dd").format(convertedDate) + " from " + value + " Hrs to "  + (value + 1) + " Hrs");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
            
            if (bookingDAO.checkIfUserReachedBookingLimit(loggedInUser.getId(), f.getFacilityId().getId(), convertedDate))
            {
                PrintWriter writer = response.getWriter();
                writer.write("You have already reached booking limit for " + f.getFacilityId().getName() + " facility for the day " + new SimpleDateFormat("yyyy-MM-dd").format(convertedDate));
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
            
            if (!bookingDAO.checkSlotAvailability(facility_instance_id, value, convertedDate))
            {
                PrintWriter writer = response.getWriter();
                writer.write("Booking Slot not available. This can happen when some other user books the same slot you were trying to book. Please try again");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }
            try {
                    bookingDAO.create(b);
                    request.setAttribute("booking", b);

            } catch (Exception e) {
                Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, e);
                throw new ServletException(e);
            }
        } else if (userPath.equals("/login")) {
            /*
             * check user details and set session
             */
            Customer customer = authenticate(request);
            /*
             * if login is successful update ussBean with current customer
             * else set error message that login failed
             */
            if (customer != null) {
                session.setAttribute("customer", customer);
                response.sendRedirect("account");
                return;
            } else {
                session.setAttribute("errorMessage", "Login Failed");
                response.sendRedirect("index");
                return;
            }
            
        } else if (userPath.equals("/editProfile")) {
            /*
             * If user is not logged-in yet, re-direct to index page 
             */
            if (loggedInUser == null) {
                session.setAttribute("page", userPath);
                session.setAttribute("errorMessage",
                        "Please login to edit your Account details");
                response.sendRedirect("index.jsp");
                return;
            }
            readCustomerFromEditProfileRequest(request, loggedInUser);
            try {
                customerDAO.edit(loggedInUser);
                request.setAttribute("updateMessage", "Details Updated Successfully");
            } catch (Exception ex) {
                Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } 
        else if (userPath.equals("/submit-query"))
        {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String query = request.getParameter("query");
            UserQuery uQuery = new UserQuery(-1, name, email, query, false, new Date());
            uQuery.setPhone(phone);
            
            try
            {
                userQueryDAO.create(uQuery);
                response.setStatus(HttpServletResponse.SC_OK);
            }
            catch (Exception ex)
            {
                Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            return;
        }

        // use RequestDispatcher to forward request
        String url = "jsp" + userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return;
    }

    /**
     * Reads customer details submitted from edit profile
     *
     * @param request
     * @return
     */
    private void readCustomerFromEditProfileRequest(HttpServletRequest request, Customer customer) {
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String province = request.getParameter("province");
        String country = request.getParameter("country");
        String postalCode = request.getParameter("postalcode");

        /*
         * update object with values read from edit form
         */
        customer.setPassword(password);
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddressLine1(address1);
        customer.setAddressLine2(address2);
        customer.setCity(city);
        customer.setProvince(province);
        customer.setCountry(country);
        customer.setPostalCode(postalCode);
    }

    private Customer authenticate(HttpServletRequest request) {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        return customerDAO.authenticateUser(login, password);
    }

    /**
     * This method extracts customer details from the incoming request and
     * returns a newly instantiated Customer object
     *
     * @param request
     * @return
     */
    private Customer readCustomerFromRegisterRequest(HttpServletRequest request) {
        String login = request.getParameter("reg_login");
        String password = request.getParameter("reg_password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String province = request.getParameter("province");
        String country = request.getParameter("country");
        String postalCode = request.getParameter("postalcode");

        Customer user = new Customer(-1, login, password, name, email, phone, address1,
                city, province, country, postalCode);
        user.setAddressLine2(address2);
        return user;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private Object isSameDay(Date convertedDate, Date date) {
        String date1Str = new SimpleDateFormat("MM/dd/yyyy").format(convertedDate);
        String date2Str = new SimpleDateFormat("MM/dd/yyyy").format(date);
        return date1Str.equals(date2Str);
    }
}