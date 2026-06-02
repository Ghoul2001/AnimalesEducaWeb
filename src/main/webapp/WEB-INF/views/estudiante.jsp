<%@ page import="java.util.*,com.animales.model.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4">
        <div>
            <h1 class="h2">Panel estudiante</h1>
            <p class="text-muted mb-0">Seleccione una categoria para aprender e interactuar con los recursos.</p>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <a class="btn btn-bio" href="<%=request.getContextPath()%>/proyeccion3d">Actividad proyeccion 3D</a>
            <a class="btn btn-warning" href="<%=request.getContextPath()%>/quiz">Resolver quiz</a>
        </div>
    </div>
    <% if (request.getAttribute("error") != null) { %><div class="alert alert-danger"><%=request.getAttribute("error")%></div><% } %>

    <section class="card border-0 shadow-sm mb-4 actividad-3d-card" aria-labelledby="actividad3dTitulo">
        <div class="card-body row align-items-center g-3">
            <div class="col-lg-8">
                <span class="badge text-bg-warning mb-2">Nuevo recurso interactivo</span>
                <h2 id="actividad3dTitulo" class="h4">Actividad de proyeccion 3D</h2>
                <p class="mb-0">Observa modelos 3D con apariencia realista de un pez vertebrado y una mariposa invertebrada, activa realidad aumentada en celular y registra tu observacion para que aparezca en la bitacora del administrador.</p>
            </div>
            <div class="col-lg-4 text-lg-end">
                <a class="btn btn-bio btn-lg" href="<%=request.getContextPath()%>/proyeccion3d">Abrir actividad 3D</a>
            </div>
        </div>
    </section>
    <div class="row g-4">
        <%
            List<Category> categorias = (List<Category>) request.getAttribute("categorias");
            if (categorias != null) {
                for (Category c : categorias) {
        %>
        <div class="col-md-6 col-lg-4">
            <article class="card h-100 shadow-sm card-bio">
                <img src="<%=request.getContextPath()%>/<%=c.getImagen()%>" class="card-img-top animal-photo" alt="Imagen de <%=c.getNombre()%>">
                <div class="card-body d-flex flex-column">
                    <span class="badge text-bg-success align-self-start mb-2"><%=c.getTipo()%></span>
                    <h2 class="h5"><%=c.getNombre()%></h2>
                    <p><%=c.getDescripcion()%></p>
                    <a class="btn btn-bio mt-auto" href="<%=request.getContextPath()%>/leccion?id=<%=c.getId()%>">Abrir leccion</a>
                </div>
            </article>
        </div>
        <%      }
            }
        %>
    </div>
</div>
<jsp:include page="includes/footer.jsp" />
