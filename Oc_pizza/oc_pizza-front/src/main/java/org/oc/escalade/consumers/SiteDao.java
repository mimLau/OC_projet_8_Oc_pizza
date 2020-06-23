package org.oc.escalade.consumers;

import org.oc.escalade.models.Place;
import org.oc.escalade.models.Site;

import java.util.List;
import java.util.Map;

public interface SiteDao {

     List<Site> getAllSites();
     Site addSite(Site site);
     Site findSiteById( Long id );
     void updateNbOfSectors( Long id );
     void updateTag( Long id, Boolean tag );
     List<Site> getSitesByPlaceId( Long placeId );
     List<Site> getSitesByTag( Boolean tagged );
     List<Site> getSitesBySearchParams( Map<String, Object> criteriaResearchMap);
     int getMaxNbSector();
}
