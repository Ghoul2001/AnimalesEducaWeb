package com.animales.servlet;

import com.animales.config.SecurityUtil;
import com.animales.dao.BitacoraDAO;
import com.animales.dao.UsuarioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        cargar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        UsuarioDAO usuarios = new UsuarioDAO(getServletContext());
        BitacoraDAO bitacora = new BitacoraDAO(getServletContext());
        HttpSession s = request.getSession(false);
        int adminId = (Integer) s.getAttribute("userId");
        String action = request.getParameter("action");
        try {
            if ("crear".equals(action)) {
                String nombre = request.getParameter("nombre");
                String email = request.getParameter("email");
                String clave = request.getParameter("clave");
                String rol = request.getParameter("rol");
                if (!SecurityUtil.isValidEmail(email) || !SecurityUtil.isValidPassword(clave)) {
                    request.setAttribute("error", "Correo invalido o clave menor a 8 caracteres.");
                } else {
                    usuarios.insertar(nombre, email, clave, rol);
                    bitacora.registrar(adminId, "CREAR_USUARIO", "Administrador", "Creo usuario: " + email);
                    request.setAttribute("ok", "Usuario creado correctamente.");
                }
            } else if ("bloquear".equals(action)) {
                usuarios.cambiarEstado(Integer.parseInt(request.getParameter("id")), "BLOQUEADO");
                bitacora.registrar(adminId, "BLOQUEAR", "Administrador", "Bloqueo un usuario");
            } else if ("activar".equals(action)) {
                usuarios.cambiarEstado(Integer.parseInt(request.getParameter("id")), "ACTIVO");
                bitacora.registrar(adminId, "ACTIVAR", "Administrador", "Activo un usuario");
            } else if ("rol".equals(action)) {
                usuarios.cambiarRol(Integer.parseInt(request.getParameter("id")), request.getParameter("rol"));
                bitacora.registrar(adminId, "ACTUALIZAR_ROL", "Administrador", "Actualizo rol de usuario");
            } else if ("aprobar".equals(action)) {
                bitacora.aprobar(Integer.parseInt(request.getParameter("id")));
                bitacora.registrar(adminId, "APROBAR_BITACORA", "Administrador", "Aprobo registro de bitacora");
            }
            cargar(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error en administracion: " + e.getMessage());
            cargar(request, response);
        }
    }

    private void cargar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("usuarios", new UsuarioDAO(getServletContext()).listarTodos());
            request.setAttribute("bitacora", new BitacoraDAO(getServletContext()).listar());
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo cargar informacion: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
    }
}
