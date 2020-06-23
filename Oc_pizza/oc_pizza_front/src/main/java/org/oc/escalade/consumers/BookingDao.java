package org.oc.escalade.consumers;

import org.oc.escalade.models.Booking;
import org.oc.escalade.models.Status;

import java.util.List;

public interface BookingDao {

    Booking addBooking( Booking book );
    List<Booking> findBookingsByUserRequestId( Long userRequestId );
    List<Booking> findBookingsByUserLenderId( Long userLenderId );
    void updateBookingStatus( Long bookingId, Status status );
    Booking findBookingById( Long bookingId);
    Booking findBookingByStatusAndTopoId( Status status, Long topoId );

}
