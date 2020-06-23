package org.oc.escalade.utils;

import javax.servlet.http.HttpServletRequest;

public class RetrieveParamValue {

    public final static String getParameterValue(HttpServletRequest req, String param ) {
        String paramValue = req.getParameter( param );
        return paramValue;
    }
}
