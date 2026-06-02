package com.animales.dao;

import com.animales.config.DBConnection;
import com.animales.config.SecurityUtil;
import com.animales.model.User;
import javax.servlet.ServletContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    private final ServletContext context;

    public UsuarioDAO(ServletContext context) {
        this.context = context;
    }

    public User login(String email, String clave) throws SQLException {
        String sql = "SELECT id_usuario, nombre, email, rol, estado, fecha_registro FROM usuarios WHERE email=? AND clave_hash=?";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, SecurityUtil.sha256(clave));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public boolean existeEmail(String email) throws SQLException {
        String sql = "SELECT 1 FROM usuarios WHERE email=?";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void insertar(String nombre, String email, String clave, String rol) throws SQLException {
        String sql = "INSERT INTO usuarios(nombre, email, clave_hash, rol, estado) VALUES (?, ?, ?, ?, 'ACTIVO')";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, email);
            ps.setString(3, SecurityUtil.sha256(clave));
            ps.setString(4, rol);
            ps.executeUpdate();
        }
    }

    public List<User> listarTodos() throws SQLException {
        List<User> lista = new ArrayList<>();
        String sql = "SELECT id_usuario, nombre, email, rol, estado, fecha_registro FROM usuarios ORDER BY id_usuario";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(map(rs));
        }
        return lista;
    }

    public void cambiarEstado(int id, String estado) throws SQLException {
        String sql = "UPDATE usuarios SET estado=? WHERE id_usuario=?";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    public void cambiarRol(int id, String rol) throws SQLException {
        String sql = "UPDATE usuarios SET rol=? WHERE id_usuario=?";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, rol);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id_usuario"));
        u.setNombre(rs.getString("nombre"));
        u.setEmail(rs.getString("email"));
        u.setRol(rs.getString("rol"));
        u.setEstado(rs.getString("estado"));
        u.setFechaRegistro(String.valueOf(rs.getTimestamp("fecha_registro")));
        return u;
    }
}
