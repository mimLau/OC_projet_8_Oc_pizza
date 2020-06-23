package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.SitesManager;
import org.oc.escalade.models.Site;
import org.oc.escalade.utils.RatingManager;
import org.oc.escalade.utils.TagsManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ListSitesServlet", urlPatterns = "/listSites")
public class ListSitesServlet extends HttpServlet {
    public static final String SITE_VIEW = "/WEB-INF/jsp/listSites.jsp";
    public static final String SITE_PAGE = "/listSites";
    public static final String ALL_SITES_ATT = "sites";
    public static final String SEARCHED_SITES_ATT = "sites";
    public static final String COUNTRY_REGION_ATT = "countryRegions";
    public static final String RATINGS_ATT = "ratings";
    public static final String TAGS_ATT = "tags";
    public static final String NB_SECTOR_MAX_ATT = "nbSectorMax";
    public static final String LIST_ATT = "list";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        SitesManager sitesManager = new SitesManager();
        List<Site> searchedSites = sitesManager.searchSite( req );

        req.setAttribute(SEARCHED_SITES_ATT, searchedSites);
        req.setAttribute(LIST_ATT, false);
        this.getServletContext().getRequestDispatcher(SITE_VIEW).forward(req, res);
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        List<String> ratingValues = RatingManager.getAllRatings();
        Map<String, Boolean> tags = TagsManager.getAllTags();

        SitesManager sitesManager = new SitesManager();
        List<Site> allSites = sitesManager.getAllSites();
        Map<String, List<String>> countriesWithRegions = sitesManager.listOfCountriesRegions();
        int nbSectorMax = sitesManager.getSectorNbMax();

        req.getServletContext().setAttribute(COUNTRY_REGION_ATT, countriesWithRegions);
        req.getServletContext().setAttribute(RATINGS_ATT, ratingValues);
        req.getServletContext().setAttribute(TAGS_ATT, tags);
        req.setAttribute(ALL_SITES_ATT, allSites);
        req.setAttribute(LIST_ATT, true);
        req.getServletContext().setAttribute(NB_SECTOR_MAX_ATT, nbSectorMax);

        req.getServletContext().removeAttribute("chosen_region");
        req.getServletContext().removeAttribute("chosen_tag");
        req.getServletContext().removeAttribute("chosen_sectorNb");
        req.getServletContext().removeAttribute("chosen_rating");

        req.getServletContext().setAttribute("previousPage", SITE_PAGE);

        this.getServletContext().getRequestDispatcher(SITE_VIEW).forward(req, res);
    }
}
