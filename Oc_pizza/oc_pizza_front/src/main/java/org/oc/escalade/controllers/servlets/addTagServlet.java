package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.SitesManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "addTagServlet", urlPatterns = "/auth/addTag")
public class addTagServlet extends HttpServlet {
    public static final String  LIST_SITES_PAGE = "/listSites";
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        SitesManager sitesManager = new SitesManager();
        sitesManager.updateTag( req );
        res.sendRedirect(req.getContextPath() + LIST_SITES_PAGE);
    }
}
