package com.animales.servlet;

import com.animales.dao.BitacoraDAO;
import com.animales.dao.CategoriaDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/estudiante")
public class EstudianteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession s = request.getSession(false);
            new BitacoraDAO(getServletContext()).registrar((Integer) s.getAttribute("userId"), "VISITA", "Estudiante", "Ingreso al panel de aprendizaje");
            request.setAttribute("categorias", new CategoriaDAO(getServletContext()).listarCategorias());
            request.getRequestDispatcher("/WEB-INF/views/estudiante.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error cargando categorias: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/estudiante.jsp").forward(request, response);
        }
    }
}
