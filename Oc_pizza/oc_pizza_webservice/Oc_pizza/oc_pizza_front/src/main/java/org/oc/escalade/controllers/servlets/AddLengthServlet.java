package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.LengthsManager;
import org.oc.escalade.models.Length;
import org.oc.escalade.models.Way;
import org.oc.escalade.utils.RatingManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AddLengthServlet", urlPatterns = "/auth/addLength")
public class AddLengthServlet extends HttpServlet {
    public static final String  ADD_LENGTH_VIEW = "/WEB-INF/jsp/auth/addLength.jsp";
    public static final String  SHOW_WAY_PAGE = "/showWay?id=";
    public static final String RATINGS_ATT = "ratings";
    public static final String WAY_ATT = "way";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        LengthsManager lengthsManager = new LengthsManager();
        Length length = lengthsManager.addLength( req );

        Way way = (Way) req.getServletContext().getAttribute(WAY_ATT);
        res.sendRedirect(req.getContextPath() + SHOW_WAY_PAGE + way.getId());
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<String> ratingValues = RatingManager.getAllRatings();
        req.getServletContext().setAttribute(RATINGS_ATT, ratingValues);
        this.getServletContext().getRequestDispatcher(ADD_LENGTH_VIEW).forward(req, res);
    }
}
