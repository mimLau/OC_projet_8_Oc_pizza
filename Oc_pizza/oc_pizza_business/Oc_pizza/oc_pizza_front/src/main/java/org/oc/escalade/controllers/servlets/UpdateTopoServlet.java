package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.ToposManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateTopoServlet", urlPatterns = "/auth/updateTopo")
public class UpdateTopoServlet extends HttpServlet {
    public static final String  LIST_USER_TOPOS_PAGE = "/auth/listTopos";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {

    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        ToposManager toposManager = new ToposManager();
        toposManager.updateTopoAvailibility( req );

        res.sendRedirect(req.getContextPath() + LIST_USER_TOPOS_PAGE );
    }
}
