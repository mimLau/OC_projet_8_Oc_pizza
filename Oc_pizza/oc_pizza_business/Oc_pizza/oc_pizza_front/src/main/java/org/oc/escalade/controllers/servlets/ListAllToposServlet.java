package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.ToposManager;
import org.oc.escalade.models.Topo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ListAllToposServlet", urlPatterns = "/auth/listAllTopos")
public class ListAllToposServlet extends HttpServlet {
    public static final String  LIST_TOPOS_VIEW = "/WEB-INF/jsp/auth/listAllTopos.jsp";
    public static final String TOPOS_ATT = "topos";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {

    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        ToposManager toposManager = new ToposManager();
        Map<Topo, Boolean> topos = toposManager.getAllTopos( req );
        req.setAttribute( TOPOS_ATT, topos );
        this.getServletContext().getRequestDispatcher( LIST_TOPOS_VIEW ).forward( req, res );
    }
}
