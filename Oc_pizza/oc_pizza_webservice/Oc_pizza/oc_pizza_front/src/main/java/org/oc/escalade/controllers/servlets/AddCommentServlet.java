package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.CommentsManager;
import org.oc.escalade.models.Site;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddCommentServlet", urlPatterns = "/auth/addComment")
public class AddCommentServlet extends HttpServlet {
    public static final String  SHOW_SITE_PAGE = "/showSite?id=";
    public static final String SITE_ATT = "site";

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        CommentsManager commentsManager = new CommentsManager();
        commentsManager.addComment( req );
        Site site = (Site) req.getServletContext().getAttribute( SITE_ATT );
        res.sendRedirect(req.getContextPath() + SHOW_SITE_PAGE + site.getId());
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    }
}
