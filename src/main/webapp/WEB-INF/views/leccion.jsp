<%@ page import="java.util.*,com.animales.model.Category,com.animales.model.ResourceItem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5">
    <% if (request.getAttribute("error") != null) { %><div class="alert alert-danger"><%=request.getAttribute("error")%></div><% } %>
    <%
        Category c = (Category) request.getAttribute("categoria");
        List<ResourceItem> recursos = (List<ResourceItem>) request.getAttribute("recursos");
        if (c != null) {
    %>
    <div class="row g-4 align-items-center mb-4 lesson-hero">
        <div class="col-lg-7">
            <a href="<%=request.getContextPath()%>/estudiante" class="btn btn-outline-secondary btn-sm mb-3">Volver</a>
            <span class="badge text-bg-success mb-2"><%=c.getTipo()%></span>
            <h1 class="display-6 mb-3"><%=c.getNombre()%></h1>
            <p class="lead"><%=c.getDescripcion()%></p>
            <p class="text-muted mb-0">Revisa la fotografía, escucha el sonido del animal y explora el modelo 3D de esta categoría.</p>
        </div>
        <div class="col-lg-5 text-center">
            <img class="lesson-img lesson-photo" src="<%=request.getContextPath()%>/<%=c.getImagen()%>?v=multimedia2" alt="Fotografía real de <%=c.getNombre()%>">
        </div>
    </div>

    <section class="row g-4" aria-label="Recursos multimedia de la categoría">
        <% if (recursos != null && !recursos.isEmpty()) { %>
            <% for (ResourceItem r : recursos) { %>
            <div class="col-lg-4 col-md-6">
                <article class="card h-100 shadow-sm multimedia-card">
                    <% if ("IMAGEN".equals(r.getTipo())) { %>
                        <img class="card-img-top multimedia-img" src="<%=request.getContextPath()%>/<%=r.getUrl()%>?v=multimedia2" alt="<%=r.getTitulo()%>">
                    <% } %>
                    <div class="card-body d-flex flex-column">
                        <span class="badge text-bg-success align-self-start mb-3"><%=r.getTipo()%></span>
                        <h2 class="h5"><%=r.getTitulo()%></h2>
                        <p><%=r.getDescripcion()%></p>

                        <% if ("MODELO3D".equals(r.getTipo())) { %>
                            <model-viewer class="model-card mt-auto" src="<%=request.getContextPath()%>/<%=r.getUrl()%>?v=multimedia2" poster="<%=request.getContextPath()%>/<%=c.getImagen()%>?v=multimedia2" alt="<%=r.getTitulo()%>" ar ar-modes="webxr scene-viewer quick-look" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <% } else if ("AUDIO".equals(r.getTipo())) { %>
                            <audio controls class="w-100 mt-auto" aria-label="Sonido de <%=c.getNombre()%>">
                                <source src="<%=request.getContextPath()%>/<%=r.getUrl()%>?v=multimedia2" type="audio/wav">
                                Su navegador no soporta audio.
                            </audio>
                        <% } else if ("VIDEO".equals(r.getTipo())) { %>
                            <div class="ratio ratio-16x9 mt-auto"><iframe src="<%=r.getUrl()%>" title="Video educativo" allowfullscreen></iframe></div>
                        <% } %>
                    </div>
                </article>
            </div>
            <% } %>
        <% } else { %>
            <div class="col-12"><div class="alert alert-warning">No hay recursos multimedia cargados para esta categoría.</div></div>
        <% } %>
    </section>
    <% } %>
</div>
<jsp:include page="includes/footer.jsp" />
