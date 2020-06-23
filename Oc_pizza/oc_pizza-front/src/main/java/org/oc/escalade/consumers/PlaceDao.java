package org.oc.escalade.consumers;

import org.oc.escalade.models.Place;

import java.util.List;

public interface PlaceDao {

    Place addPlace(Place place);
    Place findPlaceByCountryAndRegion(String country, String region);
    List<String> getAllDistinctCountries();
    List<Place> getPlaceByCountryName(String country);
    Place  getPlaceByRegionName(String region);
}
