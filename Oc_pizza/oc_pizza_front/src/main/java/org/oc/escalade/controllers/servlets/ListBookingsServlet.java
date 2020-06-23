package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.BookingsManager;
import org.oc.escalade.models.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListBookingsServlet", urlPatterns = "/auth/listBookings")
public class ListBookingsServlet extends HttpServlet {
    public static final String  LIST_BOOKINGS_VIEW = "/WEB-INF/jsp/auth/listBookings.jsp";
    public static final String BOOKINGS_ATT = "bookings";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        BookingsManager bookingsManager = new BookingsManager();
        List<Booking> userBookings = bookingsManager.getBookingsByUserLenderId( req );
        req.setAttribute( BOOKINGS_ATT, userBookings );

        this.getServletContext().getRequestDispatcher( LIST_BOOKINGS_VIEW ).forward( req, res );
    }
}
