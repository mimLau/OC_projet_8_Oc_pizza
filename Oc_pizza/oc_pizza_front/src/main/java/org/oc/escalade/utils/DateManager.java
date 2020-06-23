
package org.oc.escalade.utils;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

public  class DateManager {

    public static final String getLocalDate () {
        Date today = new Date();
        DateFormat medDateFormat = DateFormat.getDateTimeInstance(
                DateFormat.MEDIUM,
                DateFormat.MEDIUM, new Locale("FR", "fr"));
        return medDateFormat.format( today );
    }

    public static final String getLocalDate (Date date) {
        DateFormat shortDateFormat = DateFormat.getDateInstance(DateFormat.SHORT, Locale.FRANCE);
        return shortDateFormat.format( date );
    }
}
