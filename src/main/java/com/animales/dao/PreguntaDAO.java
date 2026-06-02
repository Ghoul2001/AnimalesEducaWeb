package com.animales.dao;

import com.animales.config.DBConnection;
import com.animales.model.Question;
import javax.servlet.ServletContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreguntaDAO {
    private final ServletContext context;

    public PreguntaDAO(ServletContext context) { this.context = context; }

    public List<Question> listar() throws SQLException {
        List<Question> lista = new ArrayList<>();
        String sql = "SELECT id_pregunta, pregunta, opcion_a, opcion_b, opcion_c, respuesta_correcta FROM preguntas ORDER BY id_pregunta";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id_pregunta"));
                q.setPregunta(rs.getString("pregunta"));
                q.setOpcionA(rs.getString("opcion_a"));
                q.setOpcionB(rs.getString("opcion_b"));
                q.setOpcionC(rs.getString("opcion_c"));
                q.setRespuestaCorrecta(rs.getString("respuesta_correcta"));
                lista.add(q);
            }
        }
        return lista;
    }

    public void registrarRespuesta(int usuarioId, int preguntaId, String respuesta, boolean correcto) throws SQLException {
        String sql = "INSERT INTO interacciones(usuario_id, pregunta_id, respuesta_usuario, correcto) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ps.setInt(2, preguntaId);
            ps.setString(3, respuesta);
            ps.setBoolean(4, correcto);
            ps.executeUpdate();
        }
    }
}
