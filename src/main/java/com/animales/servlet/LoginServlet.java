package com.animales.servlet;

import com.animales.dao.BitacoraDAO;
import com.animales.dao.UsuarioDAO;
import com.animales.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String clave = request.getParameter("clave");
        UsuarioDAO dao = new UsuarioDAO(getServletContext());
        BitacoraDAO bitacora = new BitacoraDAO(getServletContext());
        try {
            User user = dao.login(email, clave);
            if (user == null) {
                bitacora.registrar(null, "LOGIN_FALLIDO", "Autenticacion", "Intento con correo: " + email);
                request.setAttribute("error", "Correo o clave incorrectos.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
            if ("BLOQUEADO".equals(user.getEstado())) {
                bitacora.registrar(user.getId(), "LOGIN_BLOQUEADO", "Autenticacion", "Usuario bloqueado intento ingresar");
                request.setAttribute("error", "Tu usuario esta bloqueado. Contacta al administrador.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("nombre", user.getNombre());
            session.setAttribute("rol", user.getRol());
            bitacora.registrar(user.getId(), "LOGIN", "Autenticacion", "Ingreso correcto al sistema");
            if ("ADMIN".equals(user.getRol())) response.sendRedirect(request.getContextPath() + "/admin");
            else response.sendRedirect(request.getContextPath() + "/estudiante");
        } catch (Exception e) {
            request.setAttribute("error", "Error de conexion o consulta: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
