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

@WebServlet(name = "ListUserToposServlet", urlPatterns = "/auth/listTopos")
public class ListUserToposServlet extends HttpServlet {
    public static final String  LIST_USER_TOPOS_VIEW = "/WEB-INF/jsp/auth/listMyTopos.jsp";
    public static final String TOPOS_ATT = "topos";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {


    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        ToposManager toposManager = new ToposManager();
        List<Topo> userTopos = toposManager.userTopos( req );
        req.setAttribute( TOPOS_ATT, userTopos );

        this.getServletContext().getRequestDispatcher( LIST_USER_TOPOS_VIEW ).forward( req, res );
    }
}
