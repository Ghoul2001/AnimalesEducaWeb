package com.animales.servlet;

import com.animales.dao.BitacoraDAO;
import com.animales.dao.CategoriaDAO;
import com.animales.model.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/leccion")
public class LeccionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            CategoriaDAO dao = new CategoriaDAO(getServletContext());
            Category c = dao.obtenerCategoria(id);
            request.setAttribute("categoria", c);
            request.setAttribute("recursos", dao.listarRecursos(id));
            HttpSession s = request.getSession(false);
            if (c != null) new BitacoraDAO(getServletContext()).registrar((Integer) s.getAttribute("userId"), "LECCION", "Contenido", "Reviso la categoria: " + c.getNombre());
            request.getRequestDispatcher("/WEB-INF/views/leccion.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo abrir la leccion: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/leccion.jsp").forward(request, response);
        }
    }
}
