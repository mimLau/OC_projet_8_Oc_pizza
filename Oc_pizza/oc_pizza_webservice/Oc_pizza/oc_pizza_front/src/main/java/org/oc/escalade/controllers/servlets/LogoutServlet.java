package org.oc.escalade.controllers.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {

     protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
         HttpSession session = req.getSession();
         session.removeAttribute("user");

         res.sendRedirect(req.getServletContext().getContextPath() + "/home");
    }
}
