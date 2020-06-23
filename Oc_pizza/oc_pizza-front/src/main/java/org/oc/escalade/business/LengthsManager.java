package org.oc.escalade.business;

import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.LengthDao;
import org.oc.escalade.consumers.WayDao;
import org.oc.escalade.models.Length;
import org.oc.escalade.models.Way;
import org.oc.escalade.utils.RetrieveParamValue;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;

public class LengthsManager {
    private static final String NAME_FIELD = "lengthName";
    private static String RATING_FIELD = "rating";
    private static String  LENGTH_FIELD = "lengthLength";
    private static final String ID_PARAM_NAME = "id";
    private static final String WAY_ATT =  "way";
    private LengthDao lengthDao = DaoFactory.getLengthDao();
    private WayDao wayDao = DaoFactory.getWayDao();

    /**
     * Add a new way's length.
     * @param req
     * @return The created length.
     */
    public Length addLength( HttpServletRequest req ) {
        String name = RetrieveParamValue.getParameterValue( req, NAME_FIELD ); // Retrieve the length name from field name.
        String rating = RetrieveParamValue.getParameterValue( req, RATING_FIELD ); // Retrieve the length rating from the field rating.
        long lengthLength = Long.parseLong(RetrieveParamValue.getParameterValue( req, LENGTH_FIELD )); // Retrieve the length length from the field length.
        Way way = ( Way ) req.getServletContext().getAttribute( WAY_ATT ); // Retrieve the way for which we create a new length from the Attribute.

        Length length = new Length();
        length.setName( name );
        length.setLength( lengthLength );
        length.setWay( way );
        length.setRating(rating);
        length = lengthDao.addLength( length );

        wayDao.updateNbOfLengths(way.getId()); // After creating a new length for a given way, update the nbOflength way's attribute. (increment it by 1)
        return length;
    }

    /**
     *  Retrieve a length by its id.
     * @param req
     * @return The length we want to
     */
    public Length getLengthById ( HttpServletRequest req ) {
        String idParameter = RetrieveParamValue.getParameterValue( req, ID_PARAM_NAME ); // Retrieve the id of the Length sent by the GET method.
        Length length = new Length();

        if( idParameter != null ) {
            try {
                final Long idLong = Long.parseLong( idParameter );
                length = lengthDao.findLengthById( idLong );
            } catch( NumberFormatException nfe ) {
                System.out.println("ERROR: l'id entré n'est pas un nombre.");
            }
        }
        return length;
    }
}
