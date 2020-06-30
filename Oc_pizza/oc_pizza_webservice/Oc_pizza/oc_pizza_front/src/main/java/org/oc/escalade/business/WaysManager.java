package org.oc.escalade.business;

import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.SectorDao;
import org.oc.escalade.consumers.WayDao;
import org.oc.escalade.models.Rating;
import org.oc.escalade.models.Sector;
import org.oc.escalade.models.Way;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public final class WaysManager {

    private static String WAY_NAME_FIELD = "wayName";
    private static String RATING_FIELD = "rating";
    private static String  LENGTH_FIELD = "length";
    private static final String ID_PARAM_NAME = "id";
    private WayDao wayDao = DaoFactory.getWayDao();
    private SectorDao sectorDao = DaoFactory.getSectorDao();

    public Way addWay( HttpServletRequest req ) {
        String wayName = getParamValue(req, WAY_NAME_FIELD);
        String rating = getParamValue(req, RATING_FIELD);
        long length = Long.parseLong(getParamValue(req, LENGTH_FIELD));
        Sector sector = ( Sector ) req.getServletContext().getAttribute("sector" );

        Way way = new Way();
        way.setName(wayName);
        way.setRating(rating);
        way.setLength(length);
        way.setSector(sector);
        wayDao.addWay(way);

        sectorDao.updateNbOfWays(sector.getId());
        return way;
    }

    public Way getWayById ( HttpServletRequest req ) {
        String idParameter = getParamValue(req, ID_PARAM_NAME);
        Way requestedWay = new Way();

        if(idParameter != null) {
            try {
                final Long idLong = Long.parseLong( idParameter );
                requestedWay = wayDao.findWayById( idLong );
            } catch( NumberFormatException nfe ) {
                System.out.println("ERROR: l'id entré n'est pas un nombre.");
            }
        }
        return requestedWay;
    }

    private static String getParamValue( HttpServletRequest req, String param ){
        String paramValue = req.getParameter( param );
        return paramValue;
    }

}
