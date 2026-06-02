package com.animales.dao;

import com.animales.config.DBConnection;
import com.animales.model.Category;
import com.animales.model.ResourceItem;
import javax.servlet.ServletContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {
    private final ServletContext context;

    public CategoriaDAO(ServletContext context) { this.context = context; }

    public List<Category> listarCategorias() throws SQLException {
        List<Category> lista = new ArrayList<>();
        String sql = "SELECT id_categoria, nombre, tipo, descripcion, imagen FROM categorias ORDER BY id_categoria";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(map(rs));
        }
        return lista;
    }

    public Category obtenerCategoria(int id) throws SQLException {
        String sql = "SELECT id_categoria, nombre, tipo, descripcion, imagen FROM categorias WHERE id_categoria=?";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public List<ResourceItem> listarRecursos(int categoriaId) throws SQLException {
        List<ResourceItem> lista = new ArrayList<>();
        String sql = "SELECT id_recurso, categoria_id, titulo, tipo, url, descripcion FROM recursos WHERE categoria_id=? ORDER BY id_recurso";
        try (Connection con = DBConnection.getConnection(context);
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoriaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ResourceItem r = new ResourceItem();
                    r.setId(rs.getInt("id_recurso"));
                    r.setCategoriaId(rs.getInt("categoria_id"));
                    r.setTitulo(rs.getString("titulo"));
                    r.setTipo(rs.getString("tipo"));
                    r.setUrl(rs.getString("url"));
                    r.setDescripcion(rs.getString("descripcion"));
                    lista.add(r);
                }
            }
        }
        return lista;
    }

    private Category map(ResultSet rs) throws SQLException {
        Category c = new Category();
        c.setId(rs.getInt("id_categoria"));
        c.setNombre(rs.getString("nombre"));
        c.setTipo(rs.getString("tipo"));
        c.setDescripcion(rs.getString("descripcion"));
        c.setImagen(rs.getString("imagen"));
        return c;
    }
}
