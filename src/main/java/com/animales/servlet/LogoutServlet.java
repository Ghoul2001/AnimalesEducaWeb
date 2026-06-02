package com.animales.servlet;

import com.animales.dao.BitacoraDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object id = session.getAttribute("userId");
            if (id != null) new BitacoraDAO(getServletContext()).registrar((Integer) id, "LOGOUT", "Autenticacion", "Salida del sistema");
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login?msg=Sesion cerrada");
    }
}
