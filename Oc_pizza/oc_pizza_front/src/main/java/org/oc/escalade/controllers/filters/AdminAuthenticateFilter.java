package org.oc.escalade.controllers.filters;

import org.oc.escalade.models.Role;
import org.oc.escalade.models.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthenticateFilter implements Filter {
    @Override
    public void init(FilterConfig fConfig) throws ServletException {

    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest HttpReq = (HttpServletRequest) req;
        HttpServletResponse HttpRes = (HttpServletResponse) res;

        User user = (User) HttpReq.getSession().getAttribute("user");
        final String HOME_PAGE = "/home";


        if (user != null ) {
            String username = user.getUsername();
            if ( username != "" ) {
                if (user.getRole().equals(Role.ADMIN)) {
                    System.out.println("Bienvenue " + username + "!");
                    chain.doFilter(req, res);
                } else {
                    System.out.println("Vous n'avez pas les droits d'accès pour cette page!");
                    HttpRes.sendRedirect(HttpReq.getContextPath() + HOME_PAGE);
                }
            }
        } else {
                System.out.println("Vous n'êtes pas authentifié!");
                HttpRes.sendRedirect(HttpReq.getContextPath() + HOME_PAGE);
        }
    }
}
