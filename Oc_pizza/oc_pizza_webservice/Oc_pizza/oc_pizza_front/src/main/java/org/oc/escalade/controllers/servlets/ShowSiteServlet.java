package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.CommentsManager;
import org.oc.escalade.business.SitesManager;
import org.oc.escalade.models.Comment;
import org.oc.escalade.models.Site;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ShowSiteServlet", urlPatterns = "/showSite")
public class ShowSiteServlet extends HttpServlet {
    public static final String  SHOW_SITE_VIEW = "/WEB-INF/jsp/showSite.jsp";
    public static final String SITE_ATT = "site";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        SitesManager sitesManager = new SitesManager();
        Site site = sitesManager.getSiteById( req );
        req.getServletContext().setAttribute( SITE_ATT, site );

        this.getServletContext().getRequestDispatcher( SHOW_SITE_VIEW ).forward( req, res );
    }
}
