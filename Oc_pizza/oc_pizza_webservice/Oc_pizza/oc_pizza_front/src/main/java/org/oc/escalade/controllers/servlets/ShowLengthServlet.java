package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.LengthsManager;
import org.oc.escalade.models.Length;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ShowLengthServlet", urlPatterns = "/showLength")
public class ShowLengthServlet extends HttpServlet {
    public static final String SHOW_LENGTH_VIEW = "/WEB-INF/jsp/showLength.jsp";
    public static final String LENGTH_ATT = "length";
    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        LengthsManager lengthsManager = new LengthsManager();
        Length length = lengthsManager.getLengthById(req);
        req.getServletContext().setAttribute( LENGTH_ATT, length);
        this.getServletContext().getRequestDispatcher(SHOW_LENGTH_VIEW).forward( req, res );
    }
}
