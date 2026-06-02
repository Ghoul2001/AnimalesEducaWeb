package com.animales.servlet;

import com.animales.dao.BitacoraDAO;
import com.animales.dao.PreguntaDAO;
import com.animales.model.Question;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        cargar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PreguntaDAO dao = new PreguntaDAO(getServletContext());
            List<Question> preguntas = dao.listar();
            int correctas = 0;
            HttpSession s = request.getSession(false);
            int usuarioId = (Integer) s.getAttribute("userId");
            for (Question q : preguntas) {
                String r = request.getParameter("p" + q.getId());
                boolean ok = q.getRespuestaCorrecta().equals(r);
                if (ok) correctas++;
                dao.registrarRespuesta(usuarioId, q.getId(), r == null ? "SIN_RESPUESTA" : r, ok);
            }
            new BitacoraDAO(getServletContext()).registrar(usuarioId, "QUIZ", "Evaluacion", "Realizo quiz. Puntaje: " + correctas + "/" + preguntas.size());
            request.setAttribute("resultado", "Puntaje obtenido: " + correctas + " de " + preguntas.size());
            request.setAttribute("preguntas", preguntas);
            request.getRequestDispatcher("/WEB-INF/views/quiz.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al evaluar quiz: " + e.getMessage());
            cargar(request, response);
        }
    }

    private void cargar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("preguntas", new PreguntaDAO(getServletContext()).listar());
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo cargar preguntas: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/quiz.jsp").forward(request, response);
    }
}
