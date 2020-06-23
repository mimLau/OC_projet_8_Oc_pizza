package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.WaysManager;
import org.oc.escalade.models.Way;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ShowWayServlet", urlPatterns = "/showWay")
public class ShowWayServlet extends HttpServlet {
    public static final String SHOW_WAY_VIEW = "/WEB-INF/jsp/showWay.jsp";
    public static final String WAY_ATT = "way";
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        WaysManager waysManager = new WaysManager();
        Way way = waysManager.getWayById(req);
        req.getServletContext().setAttribute(WAY_ATT, way);
        this.getServletContext().getRequestDispatcher( SHOW_WAY_VIEW ).forward(req, res);
    }
}
