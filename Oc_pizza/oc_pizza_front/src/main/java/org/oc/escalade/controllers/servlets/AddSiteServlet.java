package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.SitesManager;
import org.oc.escalade.models.Site;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;


@WebServlet(name = "AddSiteServlet", urlPatterns = "/auth/addSite")
public class AddSiteServlet extends HttpServlet {
    public static final String ADD_SITE_VIEW = "/WEB-INF/jsp/auth/addSite.jsp";
    public static final String LIST_SITES_PAGE = "/listSites";
    public static final String COUNTRY_REGION_ATT = "countryRegions";
    public static final String SITE_ATT = "site";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        SitesManager sitesManager = new SitesManager();
        Site site = sitesManager.addSite(req);
        req.getServletContext().setAttribute(SITE_ATT, site);
        res.sendRedirect(req.getContextPath() + LIST_SITES_PAGE );
    }
    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        SitesManager sitesManager = new SitesManager();
        Map<String, List<String>> countriesWithRegions = sitesManager.listOfCountriesRegions();
        req.setAttribute(COUNTRY_REGION_ATT, countriesWithRegions);

        this.getServletContext().getRequestDispatcher(ADD_SITE_VIEW).forward(req, res);
    }
}
