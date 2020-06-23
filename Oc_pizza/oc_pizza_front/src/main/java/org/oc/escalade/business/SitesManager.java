package org.oc.escalade.business;

import org.oc.escalade.consumers.*;
import org.oc.escalade.models.*;
import org.oc.escalade.utils.RetrieveParamValue;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

public final class SitesManager {

    private SiteDao siteDao = DaoFactory.getSiteDao();
    private PlaceDao placeDao = DaoFactory.getPlaceDao();
    private WayDao wayDao = DaoFactory.getWayDao();
    private LengthDao lengthDao = DaoFactory.getLengthDao();
    private static final String NAME_FIELD = "name";
    private static final String REGION_INPUT = "region";
    private static final String DESCRIPTION_FIELD = "description";
    private static final String ID_PARAMETER_NAME = "id";
    private static final String TAG_PARAMETER_NAME = "tag";
    private static final String OFFICIAL_INPUT = "official";
    private static final String RATING_INPUT = "rating";
    private static final String SECTOR_NB_INPUT ="sectorsNb";

    public List<Site> getAllSites() {
         return siteDao.getAllSites();
    }

    private List<String> getAllCountries() {
        List<String> countries = placeDao.getAllDistinctCountries();
        return countries;
    }

    public  Map<String, List<String>> listOfCountriesRegions() {
        Map<String, List<String>> countrysRegions = new LinkedHashMap<>();
        List<String> countries = getAllCountries();
        List<String> regions = new ArrayList<>();
        List<Place> places;

        for( String country:countries ) {
            places = placeDao.getPlaceByCountryName( country );

            for ( Place place : places ) {
                regions.add( place.getRegion() );
            }

            List<String> regionsBis = new ArrayList<>( regions );
            regions.clear();
            countrysRegions.put( country, regionsBis );
        }
        return countrysRegions;
    }

    public Site addSite(HttpServletRequest req) {
        String name = RetrieveParamValue.getParameterValue( req, NAME_FIELD );
        String region = RetrieveParamValue.getParameterValue( req, REGION_INPUT );
        String description = RetrieveParamValue.getParameterValue( req, DESCRIPTION_FIELD );

        User user = (User) req.getSession().getAttribute("user");
        Place place = placeDao.getPlaceByRegionName( region );

        Site site = new Site();
        site.setDescription(description);
        site.setName( name );
        site.setPlace( place );
        site.setSiteOwner( user );

        site = siteDao.addSite( site );
        return site;
    }

    public Site getSiteById( HttpServletRequest req ) {
        String idParameter = RetrieveParamValue.getParameterValue(req, ID_PARAMETER_NAME );
        Site requestedSite = new Site();

        if(idParameter != null) {
            try {
                final Long idLong = Long.parseLong( idParameter );
                requestedSite = siteDao.findSiteById( idLong );
            } catch( NumberFormatException nfe ) {
                System.out.println("ERROR: l'id entré n'est pas un nombre.");
            }
        }
        return requestedSite;
    }

    public void updateTag(HttpServletRequest req) {
        Long idParameter = Long.parseLong( RetrieveParamValue.getParameterValue( req, ID_PARAMETER_NAME ));
        Boolean tag = Boolean.parseBoolean( RetrieveParamValue.getParameterValue( req, TAG_PARAMETER_NAME ));
        siteDao.updateTag( idParameter,tag );
    }

    public int getSectorNbMax() {
        return siteDao.getMaxNbSector();
    }

    /**
     *
     * @param req
     * @return
     */
    public List<Site> searchSite(HttpServletRequest req ) {
        /*
          Map which will contain all getSitesBySearchParams's parameters and their type.
         */
        Map<String, Object> criteriaResearchMap =new HashMap<String, Object>();
        List<Long> sitesIds = new ArrayList<>();
        List<Site> sites;
        Place place;
        Integer sectorNb;
        Boolean officialSite;

        /*
         Retrieve all INPUT' contents from research form.
         */
        String region = RetrieveParamValue.getParameterValue( req, REGION_INPUT );
        String rating = RetrieveParamValue.getParameterValue( req, RATING_INPUT);
        String officialSite_param = RetrieveParamValue.getParameterValue( req, OFFICIAL_INPUT );
        String sectorNb_param = RetrieveParamValue.getParameterValue( req, SECTOR_NB_INPUT );

        /*
         Treatment of the search criteria "TAGGED" of the site.
         If input officialSite isn't empty.
         Add official value (which is true) and tagged key to the Map criteriaResearchMap.
         Add tagged key  and true as value to the Map setActiveCriteria.
         Register the "TAGGED" criteria research and its value in the context to add it to the next research.
         */
        if( officialSite_param != null ) {
            officialSite = Boolean.parseBoolean( officialSite_param );
            criteriaResearchMap.put("tagged", officialSite );
            req.getServletContext().setAttribute("chosen_tag", officialSite);


        /*
         If input officialSite is empty but was selected for a previous research.
         And if it wasn't reset in the meantime, this criteria should be still in the context.
         Verify if it is still in the context, if it is, we retrieve this criteria and its value and put them in
         criteriaResearchMap to retrieve it as parameter for getSitesBySearchParams() method.
         */

        } else
            criteriaResearchMap.put("tagged", null);



        /*
         Treatment of the search criteria "PLACE" of the site.
         Same as search criteria "TAGGED".
         */
        if( region != null && !region.isEmpty() ) {
            place = placeDao.getPlaceByRegionName( region );
            criteriaResearchMap.put("place", place );
            req.getServletContext().setAttribute("chosen_region", region );
            req.getServletContext().setAttribute("chosen_place", place );

        } else
            criteriaResearchMap.put("place", null );

        /*
         Treatment of the search criteria "SECTOR NUMBER" of the site.
         Same as search criteria "TAGGED".
         */
        if( sectorNb_param != null && !sectorNb_param.isEmpty() ) {
            sectorNb = Integer.parseInt( sectorNb_param );
            criteriaResearchMap.put("sectorNb", sectorNb );
            req.getServletContext().setAttribute("chosen_sectorNb", sectorNb );

        } else
            criteriaResearchMap.put("sectorNb", null );
        /*
         Treatment of the search criteria "RATING" of the site.
         Same as search criteria "TAGGED".
         */
        if( rating != null && !rating.isEmpty() ) {
            List<Way> ways = wayDao.findWaysByRating( rating );
            List<Length> lengths = lengthDao.findLengthsByRating( rating );

            for( Length length : lengths ) {
                sitesIds.add(length.getWay().getSector().getSite().getId());
            }

            for( Way way : ways ) {
                Long id = way.getSector().getSite().getId();
                if(!sitesIds.contains( id )) sitesIds.add( id );
            }

            criteriaResearchMap.put("sitesIds", sitesIds );
            req.getServletContext().setAttribute("chosen_rating", rating );
            req.getServletContext().setAttribute("sitesIds", sitesIds );

        } else
            criteriaResearchMap.put("sitesIds", null );

        sites = siteDao.getSitesBySearchParams( criteriaResearchMap );
        return sites;
    }
}
