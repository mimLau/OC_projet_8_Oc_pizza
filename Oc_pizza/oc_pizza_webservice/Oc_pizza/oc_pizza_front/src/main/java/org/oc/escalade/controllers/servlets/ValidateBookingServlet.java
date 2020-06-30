package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.BookingsManager;
import org.oc.escalade.business.ToposManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ValidateBookingServlet", urlPatterns = "/auth/validateBooking")
public class ValidateBookingServlet extends HttpServlet {
    public static final String  LIST_BOOKINGS_VIEW = "/auth/listBookings";
    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {

    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        BookingsManager bookingsManager = new BookingsManager();
        bookingsManager.updateBookingStatusToAccepted( req );
        res.sendRedirect(req.getContextPath() + LIST_BOOKINGS_VIEW );
    }
}
