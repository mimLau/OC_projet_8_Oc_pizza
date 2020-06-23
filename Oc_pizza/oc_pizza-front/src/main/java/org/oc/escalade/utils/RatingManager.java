package org.oc.escalade.utils;

import org.oc.escalade.models.Rating;

import java.util.List;

public final class RatingManager {
    public static List<String> getAllRatings() {
        return  Rating.getAllRtingsValues();
    }
}
