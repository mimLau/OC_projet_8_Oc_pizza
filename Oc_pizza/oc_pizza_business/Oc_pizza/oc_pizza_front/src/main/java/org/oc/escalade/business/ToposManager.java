package org.oc.escalade.business;

import org.oc.escalade.consumers.BookingDao;
import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.TopoDao;
import org.oc.escalade.consumers.UserDao;
import org.oc.escalade.models.Booking;
import org.oc.escalade.models.Status;
import org.oc.escalade.models.Topo;
import org.oc.escalade.models.User;
import org.oc.escalade.utils.DateManager;
import org.oc.escalade.utils.RetrieveParamValue;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class ToposManager {
    private final static String DESCRIPTION_FIELD = "topoDesc";
    private final static String NAME_FIELD = "topoName";
    private final static String RELEASE_DATE = "topoDate";
    private static final String ID_PARAMETER = "id";
    private static final String DISP_PARAMETER = "disp";
    private TopoDao topoDao = DaoFactory.getTopoDao();
    private UserDao userDao = DaoFactory.getUserDao();
    private BookingDao bookingDao = DaoFactory.getBookingDao();

    public List<Topo> userTopos( HttpServletRequest req ) {
        User user = (User) req.getSession().getAttribute("user");
        List<Topo> userTopos = topoDao.getAllToposByUserId( user.getUserId() );

        return userTopos;
    }

    public Topo addTopo( HttpServletRequest req ) throws ParseException {
        User user = (User) req.getSession().getAttribute("user");
        String description = RetrieveParamValue.getParameterValue( req, DESCRIPTION_FIELD );
        String name = RetrieveParamValue.getParameterValue( req, NAME_FIELD );
        String date = RetrieveParamValue.getParameterValue( req, RELEASE_DATE );

       SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd");
        Date releaseDate = format.parse(date);

        Topo topo = new Topo(false );
        topo.setDescription( description );
        topo.setName( name );
        topo.setReleaseDate( DateManager.getLocalDate(releaseDate) );
        topo.setTopoOwner( user );
        topoDao.addTopo( topo);

        return topo;
    }

    /**
     * List all existing topos.
     * @param req
     * @return List of all topos
     */
    public LinkedHashMap<Topo, Boolean> getAllTopos( HttpServletRequest req ) {

        //Retrieve all topos fron dbb.
        List<Topo> allTopos = topoDao.getAllTopos();

        /*
          Creation of a linkedMap which contain the top as key and as value a boolean.
          True if this topo is booked by the connected user.
          False if not.
         */
        LinkedHashMap<Topo, Boolean> topos = new LinkedHashMap<>();

        // List which will contain all booked topos.
        List<Topo> bookedTopos = new ArrayList<>();

        //Retrieve all booking done by the connected user.
        BookingsManager bookingsManager = new BookingsManager();
        List<Booking> userBookings = bookingsManager.getBookingsByUserRequestId( req );

        // Retrieve all topos which are booked by the connected user and put them in a list.
        for ( Booking booking : userBookings )  bookedTopos.add(booking.getTopo());

        /*
          For each topo in tha allTopos list we verify if there is the same topo in the bookedTopo list.
          If there is, it means that this topo is booked by the connected user, so we put the topo as key of the linkedMap and we put true as value.
          If there isn't, we add the topo as a key of the linkedMap and we put false as value.
         */
        for( Topo topo : (allTopos )) {
            if( bookedTopos.size() != 0) {
                for( Topo top : bookedTopos) {
                    if (top.getId() == topo.getId()) {
                        topos.put(topo, true);
                    }
                     else topos.put(topo, false);
                }
            } else
                topos.put(topo, false); // if bookedTopos.size is 0, it means that the connected user doesn't booked any topo.
        }
        return topos;
    }

    /**
     * Update topo's disponibility
     * @param req
     */
    public void updateTopoAvailibility( HttpServletRequest req ) {
        //Retrieve the clicked topo's id.
        Long idTopo =  Long.parseLong( RetrieveParamValue.getParameterValue( req, ID_PARAMETER ));
        // Retrieve the value of the boolean which indicates true if we want the topo become  available and false if not.
        Boolean  disp =  Boolean.parseBoolean( RetrieveParamValue.getParameterValue( req, DISP_PARAMETER ));
        topoDao.updateTopoStatus( idTopo, disp );
        // Search the booking corresponding to this topo which have a Accepted as status.
        Booking booking = bookingDao.findBookingByStatusAndTopoId(Status.ACCEPTED, idTopo );

        // If there is a booking in this topo, we change the status of this booking to expired. And this booking would not be displayed again in the list.
        if( booking != null ) {
            bookingDao.updateBookingStatus( booking.getId(), Status.EXPIRED );
        }
    }

}
