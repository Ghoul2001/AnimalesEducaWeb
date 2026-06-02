package com.animales.servlet;

import com.animales.config.SecurityUtil;
import com.animales.dao.BitacoraDAO;
import com.animales.dao.UsuarioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/registro")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String clave = request.getParameter("clave");
        UsuarioDAO dao = new UsuarioDAO(getServletContext());
        BitacoraDAO bitacora = new BitacoraDAO(getServletContext());
        try {
            if (nombre == null || nombre.trim().length() < 3) {
                request.setAttribute("error", "El nombre debe tener al menos 3 caracteres.");
            } else if (!SecurityUtil.isValidEmail(email)) {
                request.setAttribute("error", "Ingrese un correo valido.");
            } else if (!SecurityUtil.isValidPassword(clave)) {
                request.setAttribute("error", "La clave debe tener minimo 8 caracteres.");
            } else if (dao.existeEmail(email)) {
                request.setAttribute("error", "El correo ya se encuentra registrado.");
            } else {
                dao.insertar(nombre, email, clave, "ESTUDIANTE");
                bitacora.registrar(null, "REGISTRO", "Usuarios", "Nuevo estudiante registrado: " + email);
                request.setAttribute("ok", "Registro exitoso. Ahora puede iniciar sesion.");
            }
            request.getRequestDispatcher("/WEB-INF/views/registro.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al registrar: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/registro.jsp").forward(request, response);
        }
    }
}
