package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.BookingsManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "BookingTopoServlet", urlPatterns = "/auth/bookingTopo")
public class BookingTopoServlet extends HttpServlet {
    public static final String  LIST_TOPOS_PAGE = "/auth/listAllTopos";
    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        BookingsManager bookingsManager = new BookingsManager();
        bookingsManager.addBooking( req );
        res.sendRedirect(req.getContextPath() +LIST_TOPOS_PAGE);
    }
}
