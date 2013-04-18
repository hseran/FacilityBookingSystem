/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserQueryDAO;
import java.io.IOException;
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
@WebServlet(name = "AdminController", 
        urlPatterns = {"/admin",
            "/admin-home",
            "/admin-unresolved-query",
            "/admin-resolved-query",
            "/admin-orders",
            "/admin-logout",
            "/updateQueryStatus"
})
public class AdminServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @EJB
    private UserQueryDAO userQueryDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
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
        //processRequest(request, response);
        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        
        if (userPath.equals("/admin-home"))
        {
            Boolean admin = (Boolean) session.getAttribute("admin");
            if (admin == null || admin == false)
            {
                response.sendRedirect("admin");
                return;
            }
        }
        else if (userPath.equals("/admin-unresolved-query"))
        {
            Boolean admin = (Boolean) session.getAttribute("admin");
            if (admin == null || admin == false)
            {
                response.sendRedirect("admin");
                return;
            }
            try {
                //populate request attribute with feedback
                request.setAttribute("queryList",userQueryDAO.getUnResolvedQuery());
                userPath = "/admin-queries";
            } catch (Exception ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (userPath.equals("/admin-resolved-query"))
        {
            Boolean admin = (Boolean) session.getAttribute("admin");
            if (admin == null || admin == false)
            {
                response.sendRedirect("admin");
                return;
            }
            try {
                //populate request attribute with feedback
                request.setAttribute("queryList",userQueryDAO.getResolvedQuery());
                userPath = "/admin-queries";
            } catch (Exception ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (userPath.equals("/admin-logout"))
        {
            session.removeAttribute("admin");
            response.sendRedirect("admin");
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
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        if (userPath.equals("/admin"))
        {
            String password = request.getParameter("password");
            if (password.equals("admin"))
            {
                session.setAttribute("admin", true);
                response.sendRedirect("admin-home");
                return;
            }
        }
        else if (userPath.equals("/updateQueryStatus"))
        {
            int queryId = Integer.parseInt(request.getParameter("queryId"));
            String resolvedStr = request.getParameter("resolved");
            boolean flag = false;
            try {
                flag = userQueryDAO.updateQueryStatus(queryId, 
                        resolvedStr.equalsIgnoreCase("true"));
            } catch (Exception ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.getWriter().write(flag+"");
            response.setStatus(HttpServletResponse.SC_OK);
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
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to handle Admin requests";
    }// </editor-fold>
}
