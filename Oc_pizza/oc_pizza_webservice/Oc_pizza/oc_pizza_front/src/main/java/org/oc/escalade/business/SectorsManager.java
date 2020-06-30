package org.oc.escalade.business;


import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.SectorDao;
import org.oc.escalade.consumers.SiteDao;
import org.oc.escalade.models.Sector;
import org.oc.escalade.models.Site;

import javax.servlet.http.HttpServletRequest;

public final class SectorsManager {
    private static final String NAME_FIELD = "sectorName";
    private static final String  NB_WAYS_FIELD = "numberWay";
    private static final String ID_PARAM_NAME = "id";
    private SectorDao sectorDao = DaoFactory.getSectorDao();
    private SiteDao siteDao = DaoFactory.getSiteDao();

    public Sector addSector( HttpServletRequest req ) {
        String name = getParameterValue(req, NAME_FIELD );
        //String nbOfWays = getParameterValue(req, NB_WAYS_FIELD );
        Site site = ( Site ) req.getServletContext().getAttribute("site" );
        Sector sector = new Sector();
        sector.setName( name );
        sector.setSite( site );
        sector = sectorDao.addSector( sector );

        siteDao.updateNbOfSectors(site.getId());
        return sector;
    }

    public Sector getSectorById ( HttpServletRequest req ) {
        String idParameter = getParameterValue(req, ID_PARAM_NAME);
        Sector requestedSector = new Sector();

        if(idParameter != null) {
            try {
                final Long idLong = Long.parseLong( idParameter );
                requestedSector = sectorDao.findSectorById( idLong );
            } catch( NumberFormatException nfe ) {
                System.out.println("ERROR: l'id entré n'est pas un nombre.");
            }
        }
        return requestedSector;
    }

    private static String getParameterValue( HttpServletRequest req, String param ){
        String paramValue = req.getParameter( param );
        return paramValue;
    }
}
