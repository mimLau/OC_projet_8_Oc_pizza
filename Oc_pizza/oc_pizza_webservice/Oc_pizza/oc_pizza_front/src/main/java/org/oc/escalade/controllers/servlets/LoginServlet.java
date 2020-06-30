package org.oc.escalade.controllers.servlets;

import org.oc.escalade.business.LoginManager;
import org.oc.escalade.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    public static final String LOGIN_VIEW = "/WEB-INF/jsp/login.jsp";
    public static final String HOME_PAGE = "/home";
    public static final String USER_ATT = "user";
    public static final String FORM_ATT = "form";

    protected void doPost( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        LoginManager form = new LoginManager();
        User user = null;
        try {
            user = form.logUser(req);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        if( form.getErrors().isEmpty() ) {
            req.getSession().setAttribute( USER_ATT, user );
            res.sendRedirect(req.getContextPath() + HOME_PAGE );
        } else {
            req.setAttribute( FORM_ATT, form );
            this.getServletContext().getRequestDispatcher( LOGIN_VIEW ).forward( req, res );
        }
    }

    protected void doGet( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
       //req.setAttribute("login_page", true);
       Boolean loginPageDisplayed;
       loginPageDisplayed = (Boolean) req.getServletContext().getAttribute("login_disp");

        if( loginPageDisplayed != null ) {
            if( loginPageDisplayed == true) {
                req.getServletContext().removeAttribute("login_disp");
                req.getServletContext().setAttribute("login_disp", false);
                res.sendRedirect(req.getContextPath() + (String) req.getServletContext().getAttribute("previousPage") );

            } else
                this.getServletContext().getRequestDispatcher( LOGIN_VIEW ).forward( req,res );
        } else
            this.getServletContext().getRequestDispatcher( LOGIN_VIEW ).forward( req,res );
       }
}
