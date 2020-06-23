package org.oc.escalade.business;

import org.oc.escalade.consumers.DaoFactory;
import org.oc.escalade.consumers.PlaceDao;
import org.oc.escalade.models.Place;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public final class PlaceManager {

    private static final String COUNTRY_FIELD = "country";
    private static final String REGION_FIELD = "region";
    private Map<String, String> errors = new HashMap<String, String>();

    private PlaceDao placeDao = DaoFactory.getPlaceDao();
    public Map<String, String> getErrors() {
        return errors;
    }

    public Place addPlace(HttpServletRequest req) {
        String country = getFieldValue(req, COUNTRY_FIELD );
        String region = getFieldValue(req, REGION_FIELD );

        Place place = new Place();
        countryValidation(country);
        regionValidation(region);

        if(errors.isEmpty()) {
            if( regionCountryValidation( country, region) == false ){
                place.setCountry(country);
                place.setRegion(region);
                placeDao.addPlace(place);
                System.out.println("Le lieu a bien été rajouté.");
            } else {
                System.out.println("Le lieu existe déjà.");
            }
        }
        return place;
    }

    private static String getFieldValue(HttpServletRequest req, String field ){
        String fieldValue = req.getParameter(field);
        return fieldValue;
    }

    private void countryValidation(String country) {
        if ( country.isEmpty())
            setError(country, "Saisissez un pays.");
    }

    private void regionValidation(String region) {
        if ( region.isEmpty())
            setError(region, "Saisissez une région.");
    }

    private boolean regionCountryValidation( String country, String region ) {
        boolean placeExits = false;
        Place place = placeDao.findPlaceByCountryAndRegion( country, region );
        if( place != null ) placeExits = true;
        return placeExits;
    }

    private void setError( String field, String message ) {
        errors.put( field, message );
    }

}
