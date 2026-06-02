package com.animales.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletContext;

public class DBConnection {
    private static String url;
    private static String user;
    private static String password;

    public static void init(ServletContext context) {
        if (url == null) {
            url = context.getInitParameter("jdbc.url");
            user = context.getInitParameter("jdbc.user");
            password = context.getInitParameter("jdbc.password");
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException e) {
                throw new RuntimeException("No se encontro el driver JDBC de PostgreSQL. Agrega postgresql.jar en WEB-INF/lib o usa Maven.", e);
            }
        }
    }

    public static Connection getConnection(ServletContext context) throws SQLException {
        init(context);
        return DriverManager.getConnection(url, user, password);
    }
}
