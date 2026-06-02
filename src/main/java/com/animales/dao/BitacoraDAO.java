package com.animales.dao;

import com.animales.config.DBConnection;
import com.animales.model.LogEntry;
import javax.servlet.ServletContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BitacoraDAO {
    private final ServletContext context;

    public BitacoraDAO(ServletContext context) {
        this.context = context;
    }

    public void registrar(Integer usuarioId, String accion, String modulo, String descripcion) {
        String sql = "INSERT INTO bitacora(usuario_id, accion, modulo, descripcion) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (usuarioId == null) ps.setNull(1, Types.INTEGER); else ps.setInt(1, usuarioId);
            ps.setString(2, accion);
            ps.setString(3, modulo);
            ps.setString(4, descripcion);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("No se pudo registrar bitacora: " + e.getMessage());
        }
    }

    public List<LogEntry> listar() throws SQLException {
        List<LogEntry> lista = new ArrayList<>();
        String sql = "SELECT b.id_bitacora, COALESCE(u.nombre, 'Invitado') AS usuario, b.accion, b.modulo, b.descripcion, b.fecha, b.estado_revision " +
                "FROM bitacora b LEFT JOIN usuarios u ON b.usuario_id=u.id_usuario ORDER BY b.fecha DESC LIMIT 100";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LogEntry l = new LogEntry();
                l.setId(rs.getInt("id_bitacora"));
                l.setUsuario(rs.getString("usuario"));
                l.setAccion(rs.getString("accion"));
                l.setModulo(rs.getString("modulo"));
                l.setDescripcion(rs.getString("descripcion"));
                l.setFecha(String.valueOf(rs.getTimestamp("fecha")));
                l.setEstadoRevision(rs.getString("estado_revision"));
                lista.add(l);
            }
        }
        return lista;
    }

    public void aprobar(int id) throws SQLException {
        String sql = "UPDATE bitacora SET estado_revision='APROBADO' WHERE id_bitacora=?";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
