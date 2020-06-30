package org.oc.escalade.controllers.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = "/home")
public class HomeServlet extends HttpServlet {
    public static final String HOME_VIEW = "/WEB-INF/jsp/home.jsp";
    public static final String HOME_PAGE = "/home";

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getServletContext().setAttribute("previousPage", HOME_PAGE);
        this.getServletContext().getRequestDispatcher(HOME_VIEW).forward(req, res);
    }
}
