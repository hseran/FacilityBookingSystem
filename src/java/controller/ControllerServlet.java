/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BookingDAO;
import dao.CustomerDAO;
import dao.FacilityDAO;
import entity.Customer;
import entity.Facility;
import entity.FacilityInstances;
import java.io.IOException;
import java.io.PrintWriter;
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
            "/checkIDAvailabilty",
            "/register",
            "/login",
            "/logout",
            /*"/book", 
            "/view", 
            "/user-profile", 
            "/user-bookings", 
            "/cancel-booking"*/})
public class ControllerServlet extends HttpServlet {
    
    @EJB 
    CustomerDAO customerDAO;
    
    @EJB
    BookingDAO bookingDAO;    
    
    @EJB
    FacilityDAO facilityDAO;
    
    
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
        
        if (userPath.equals("index")){
            //do nothing
        }
        // if category page is requested
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
        }
        else if (userPath.equals("/register")) {
            /*
             * just redirect user to register.jsp
             */
        }
        else if (userPath.equals("/login")){
            /*
             * Just redirect user to index
             */
            response.sendRedirect("index");
            return;
        }
        else if (userPath.equals("/logout")){
            /*
             * clear the session variable & redirect to index.jsp
             */
            session.removeAttribute("customer");
            response.sendRedirect("index");
            return;
        }
        
        // use RequestDispatcher to forward request
       String url =  "jsp" + userPath + ".jsp";
       System.out.println(url);
        try 
        {
            request.getRequestDispatcher(url).forward(request, response);
        } 
        catch (Exception ex) 
        {
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
        Customer loggedInUser = (Customer)session.getAttribute("customer");
        
        if (userPath.equals("/register")) {
            Customer newCustomer = readCustomerFromRegisterRequest(request);
            customerDAO.create(newCustomer);
            /*
             * direct user to login after registration
             */
            
            session.setAttribute("customer", newCustomer);
            
            /*
             * if user was forced to register while going to some other page,
             * direct him to that page after he registers
             */
            String path = (String)(session.getAttribute("page") == null? "": session.getAttribute("page"));
            path = request.getContextPath() + path;
            
            if (path != null  && !path.isEmpty())
            {
                session.removeAttribute("page");
                response.sendRedirect(path);
                return;
            }
            else
            {
                response.sendRedirect("index.jsp");
                return;
            }
            
        }
        else if (userPath.equals("/login")){
            /*
             * check user details and set session
             */
            Customer customer = authenticate(request);
            /*
             * if login is successful update ussBean with current customer
             * else set error message that login failed
             */
            if (customer != null)
            {
                session.setAttribute("customer", customer);
            }
            else
            {
                session.setAttribute("errorMessage", "Login Failed");
            }
            
            /*
             * if user was forced to login while going to some other page,
             * direct him to that page after he logs in
             */
            String path = (String)(session.getAttribute("page") == null? "": session.getAttribute("page"));
            path = request.getContextPath() + path;
            
            if (path != null  && !path.isEmpty())
            {
                session.removeAttribute("page");
                response.sendRedirect(path);
                return;
            }
            else
            {
                response.sendRedirect("index.jsp");
                return;
            }
        }
        else if (userPath.equals("/editProfile"))
        {
            /*
             * If user is not logged-in yet, re-direct to index page 
             */
            if (loggedInUser == null)
            {
                session.setAttribute("page", userPath);
                session.setAttribute("errorMessage", 
                        "Please login to edit your Account details");
                response.sendRedirect("index.jsp");
                return;
            }
            readCustomerFromEditProfileRequest(request, loggedInUser);
            try
            {
                customerDAO.edit(loggedInUser);
                request.setAttribute("updateMessage", "Details Updated Successfully");
            }
            catch (Exception ex)
            {
                Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (userPath.equals("/checkIDAvailablility"))
        {
            /*
             * we check is the login ID is already in use by someone else
             */
            String login = request.getParameter("login");
            System.out.println("checking availability " + login);
            boolean available = customerDAO.isLoginIDAvailable(login);
            response.setContentType("text/plain");
            PrintWriter writer = response.getWriter();
            writer.print(available);
            return;
        }
        
        // use RequestDispatcher to forward request
        String url = "jsp" + userPath + ".jsp";

        try 
        {
            request.getRequestDispatcher(url).forward(request, response);
        } 
        catch (Exception ex) 
        {
            Logger.getLogger(ControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return;
    }

    
        /**
     * Reads customer details submitted from edit profile
     * @param request
     * @return 
     */
    private void readCustomerFromEditProfileRequest(HttpServletRequest request, Customer customer)
    {
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
    
    private Customer authenticate(HttpServletRequest request)
    {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        return customerDAO.authenticateUser(login, password);
    }
    
    /**
     * This method extracts customer details from the incoming request and 
     * returns a newly instantiated Customer object
     * @param request
     * @return 
     */
    private Customer readCustomerFromRegisterRequest(HttpServletRequest request)
    {
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
}
