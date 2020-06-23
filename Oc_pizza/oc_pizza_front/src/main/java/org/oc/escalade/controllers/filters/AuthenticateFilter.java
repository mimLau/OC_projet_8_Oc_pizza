package org.oc.escalade.controllers.filters;

import org.oc.escalade.models.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/auth/*")
public class AuthenticateFilter implements Filter {
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest HttpReq = (HttpServletRequest) req;
        HttpServletResponse HttpRes = (HttpServletResponse) res;

        User user = (User) HttpReq.getSession().getAttribute("user");
        final String HOME_PAGE = "/home";

        if (user != null) {
            String username = user.getUsername();
            if(user != null && username != "") {
                System.out.println("Bienvenue " + username + "!");
                chain.doFilter(req, res);
            }
        } else {

            System.out.println("Vous n'êtes pas authentifié!");
            /*RequestDispatcher rd = req.getRequestDispatcher("/home.jsp");
            rd.forward(req, resp);*/
            HttpRes.sendRedirect(HttpReq.getContextPath() + HOME_PAGE );
        }
    }
}
