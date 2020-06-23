package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.ToposManager;
import org.oc.escalade.models.Topo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;

@WebServlet(name = "AddTopoServlet", urlPatterns = "/auth/addTopo")
public class AddTopoServlet extends HttpServlet {
    public static final String ADD_TOPO_VIEW = "/WEB-INF/jsp/auth/addTopo.jsp";
    public static final String  LIST_TOPOS_VIEW = "/auth/listTopos";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        ToposManager toposManager = new ToposManager();
        try {
            Topo topo = toposManager.addTopo( req );
        } catch (ParseException e) {
            e.printStackTrace();
        }
        res.sendRedirect(req.getContextPath() + LIST_TOPOS_VIEW );
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher(ADD_TOPO_VIEW).forward(req, res);
    }
}
