package com.animales.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/estudiante", "/leccion", "/quiz", "/proyeccion3d", "/admin"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        boolean logged = session != null && session.getAttribute("userId") != null;
        if (!logged) {
            res.sendRedirect(req.getContextPath() + "/login?msg=Debe iniciar sesion");
            return;
        }
        String uri = req.getRequestURI();
        String rol = String.valueOf(session.getAttribute("rol"));
        if (uri.endsWith("/admin") && !"ADMIN".equals(rol)) {
            res.sendRedirect(req.getContextPath() + "/estudiante?msg=Acceso no autorizado");
            return;
        }
        chain.doFilter(request, response);
    }
}
