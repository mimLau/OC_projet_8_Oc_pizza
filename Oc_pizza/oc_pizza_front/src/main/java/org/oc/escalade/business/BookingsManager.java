package org.oc.escalade.business;

import org.oc.escalade.consumers.BookingDao;
import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.TopoDao;
import org.oc.escalade.models.Booking;
import org.oc.escalade.models.Status;
import org.oc.escalade.models.Topo;
import org.oc.escalade.models.User;
import org.oc.escalade.utils.RetrieveParamValue;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class BookingsManager {
    private BookingDao bookingDao = DaoFactory.getBookingDao();
    private TopoDao topoDao = DaoFactory.getTopoDao();
    private final static String ID_TOPO_PARAM = "id";
    private final static String ID_BOOKING_PARAM = "id";
    private final static String USER_SESSION = "user";

    /**
     * Create a new booking with its attributes.
     * @param req
     * @return The created booking
     */
    public Booking addBooking( HttpServletRequest req ) {
        Long topoId = Long.parseLong( RetrieveParamValue.getParameterValue( req,  ID_TOPO_PARAM ) ); // First, retrieve the topo id sent in the GET method param. (sent when click on the booking link)
        Topo topo = topoDao.findTopoById( topoId ); // Get the topo which the id corresponds to the id retrieved in param.
        User userRequest = (User) req.getSession().getAttribute( USER_SESSION ); // Retrieve the user put in session.

        Booking booking = new Booking();
        booking.setTopo( topo );
        booking.setUserRequest( userRequest ); // Set the user who booked the topo: the connected user.
        booking.setUserLender( topo.getTopoOwner() ); // Set the user who lends the topo: the topo's owner.
        booking.setStatus(Status.IN_PROGRESS); // When create a new booking, we automatically put the booking status in IN_PROGRESS.
        bookingDao.addBooking( booking );
        return booking;
    }

    /**
     * Retrieve all bookings made with the topo's owner.
     * @param req
     * @return A list of bookings.
     */
    public List<Booking> getBookingsByUserLenderId( HttpServletRequest req ) {
        User user = (User) req.getSession().getAttribute( USER_SESSION ); // Retrieve the connected user.
        List<Booking> bookings = bookingDao.findBookingsByUserLenderId( user.getUserId() ); // Get all bookings sent to the topo's owner.
        return bookings;
    }

    /**
     * Retrieve all topos done by the user.
     * @param req
     * @return A list of bookings.
     */
    public List<Booking> getBookingsByUserRequestId( HttpServletRequest req ) {
        User user = (User) req.getSession().getAttribute( USER_SESSION );
        List<Booking> bookings = bookingDao.findBookingsByUserRequestId( user.getUserId() ); // Get all the bookings done by the connected user.
        return bookings;
    }

    /**
     * When a booking is accepted by the owner, we change the booking's status into ACCEPTED.
     * @param req
     */
    public void updateBookingStatusToAccepted( HttpServletRequest req ) {
        Long bookingId = Long.parseLong( RetrieveParamValue.getParameterValue( req,  ID_BOOKING_PARAM )); // Get the id booking sent in the GET method when user clicked on accept booking button.
        bookingDao.updateBookingStatus( bookingId, Status.ACCEPTED );  // Update the booking status.
        Booking booking = bookingDao.findBookingById( bookingId ); // Find the accepted booking, by its id.
        topoDao.updateTopoStatusToTrue( booking.getTopo().getId() ); // Update the topo status.
                                                                     // Retrieve the topo's id which is booked. Update the topo's borrowed attribute at true.
    }


}
