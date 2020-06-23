package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.SectorsManager;
import org.oc.escalade.models.Sector;
import org.oc.escalade.models.Site;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddSectorServlet", urlPatterns = "/auth/addSector")
public class AddSectorServlet extends HttpServlet {
    public static final String  ADD_SECTOR_VIEW = "/WEB-INF/jsp/auth/addSector.jsp";
    public static final String  SHOW_SITE_PAGE = "/showSite?id=";
    public static final String SECTOR_ATT = "sector";
    public static final String SITE_ATT = "site";

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        SectorsManager sectorsManager = new SectorsManager();
        Sector sector = sectorsManager.addSector(req);

        req.getServletContext().setAttribute(SECTOR_ATT, sector);
        Site site = (Site) req.getServletContext().getAttribute(SITE_ATT);
        res.sendRedirect(req.getContextPath() + SHOW_SITE_PAGE + site.getId());
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher(ADD_SECTOR_VIEW).forward(req, res);
    }
}
