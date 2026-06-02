<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
    Object nombreSesion = session.getAttribute("nombre");
    Object rolSesion = session.getAttribute("rol");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BioAula Animal - Vertebrados e Invertebrados</title>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=ctx%>/assets/css/styles.css">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
</head>
<body>
<a class="skip-link" href="#contenido">Saltar al contenido principal</a>
<nav class="navbar navbar-expand-lg navbar-dark bg-bio fixed-top" aria-label="Menu principal">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="<%=ctx%>/index.jsp">
            <img src="<%=ctx%>/assets/img/logo.svg" alt="Logo BioAula Animal" width="42" height="42">
            <span>BioAula Animal</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Abrir menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div id="menu" class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item"><a class="nav-link" href="<%=ctx%>/index.jsp#categorias">Categorias</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=ctx%>/registro">Registro</a></li>
                <% if (nombreSesion == null) { %>
                    <li class="nav-item"><a class="btn btn-light ms-lg-2" href="<%=ctx%>/login">Iniciar sesion</a></li>
                <% } else { %>
                    <% if ("ADMIN".equals(String.valueOf(rolSesion))) { %>
                        <li class="nav-item"><a class="nav-link" href="<%=ctx%>/admin">Admin</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="<%=ctx%>/estudiante">Estudiante</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=ctx%>/proyeccion3d">Proyeccion 3D</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=ctx%>/quiz">Quiz</a></li>
                    <% } %>
                    <li class="nav-item"><a class="btn btn-outline-light ms-lg-2" href="<%=ctx%>/logout">Salir</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<main id="contenido" class="page-content">
