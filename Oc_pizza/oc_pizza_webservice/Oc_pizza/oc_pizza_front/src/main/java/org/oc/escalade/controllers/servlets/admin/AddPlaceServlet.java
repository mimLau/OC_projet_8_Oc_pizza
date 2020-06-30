package org.oc.escalade.controllers.servlets.admin;

import org.oc.escalade.business.PlaceManager;
import org.oc.escalade.models.Place;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddPlaceServlet", urlPatterns = "/admin/addPlace")
public class AddPlaceServlet extends HttpServlet {
    public static final String  ADD_PLACE_VIEW = "/WEB-INF/jsp/admin/addPlace.jsp";
    public static final String PLACE_ATT = "place";
    public static final String FORM_ATT = "form";


    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        PlaceManager form = new PlaceManager();
        Place place = form.addPlace( req );
        req.setAttribute( PLACE_ATT, place );
        req.setAttribute( FORM_ATT, form );
        this.getServletContext().getRequestDispatcher( ADD_PLACE_VIEW ).forward( req, res );
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
            this.getServletContext().getRequestDispatcher( ADD_PLACE_VIEW ).forward( req, res );
    }
}
