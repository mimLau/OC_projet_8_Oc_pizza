package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.SectorsManager;
import org.oc.escalade.models.Sector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ShowSecteurServlet", urlPatterns = "/showSector")
public class ShowSectorServlet extends HttpServlet {
    public static final String SHOW_SECTOR_VIEW = "/WEB-INF/jsp/showSector.jsp";
    public static final String SECTOR_ATT = "sector";
    protected void doPost( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {

    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        SectorsManager sectorsManager = new SectorsManager();
        Sector sector = sectorsManager.getSectorById( req );
        req.getServletContext().setAttribute( SECTOR_ATT, sector );
        this.getServletContext().getRequestDispatcher( SHOW_SECTOR_VIEW ).forward(req, res);
    }
}
