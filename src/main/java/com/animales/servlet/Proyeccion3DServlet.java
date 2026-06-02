package com.animales.servlet;

import com.animales.dao.BitacoraDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/proyeccion3d")
public class Proyeccion3DServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession sesion = request.getSession(false);
            Integer usuarioId = sesion == null ? null : (Integer) sesion.getAttribute("userId");
            new BitacoraDAO(getServletContext()).registrar(usuarioId, "VISITA", "Proyeccion 3D", "Ingreso a la actividad de proyeccion 3D de animales.");
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo registrar la visita: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/proyeccion3d.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            HttpSession sesion = request.getSession(false);
            int usuarioId = (Integer) sesion.getAttribute("userId");

            String modelo = normalizar(request.getParameter("modelo"));
            String tipo = normalizar(request.getParameter("tipo"));
            String estructura = normalizar(request.getParameter("estructura"));
            String observacion = request.getParameter("observacion") == null ? "" : request.getParameter("observacion").trim();

            String tipoEsperado;
            String estructuraEsperada;
            if ("PEZ".equals(modelo)) {
                tipoEsperado = "VERTEBRADO";
                estructuraEsperada = "COLUMNA";
            } else {
                tipoEsperado = "INVERTEBRADO";
                estructuraEsperada = "EXOESQUELETO";
            }

            int puntaje = 0;
            if (tipoEsperado.equals(tipo)) puntaje++;
            if (estructuraEsperada.equals(estructura)) puntaje++;

            String mensaje = "Actividad registrada. Puntaje: " + puntaje + "/2. ";
            if (puntaje == 2) {
                mensaje += "Excelente, identificaste correctamente el tipo de animal y su estructura principal.";
            } else if (puntaje == 1) {
                mensaje += "Bien, pero revisa nuevamente el modelo 3D para diferenciar columna vertebral y exoesqueleto.";
            } else {
                mensaje += "Debes volver a observar el modelo y comparar vertebrados con invertebrados.";
            }

            new BitacoraDAO(getServletContext()).registrar(
                    usuarioId,
                    "ACTIVIDAD_3D",
                    "Proyeccion 3D",
                    "Realizo actividad 3D. Modelo: " + modelo + ", tipo: " + tipo + ", estructura: " + estructura + ", puntaje: " + puntaje + "/2. Observacion: " + observacion
            );

            request.setAttribute("resultado", mensaje);
            request.setAttribute("modeloSeleccionado", modelo);
            request.setAttribute("tipoSeleccionado", tipo);
            request.setAttribute("estructuraSeleccionada", estructura);
            request.setAttribute("observacion", observacion);
        } catch (Exception e) {
            request.setAttribute("error", "Error al registrar la actividad 3D: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/proyeccion3d.jsp").forward(request, response);
    }

    private String normalizar(String valor) {
        return valor == null ? "" : valor.trim().toUpperCase();
    }
}
