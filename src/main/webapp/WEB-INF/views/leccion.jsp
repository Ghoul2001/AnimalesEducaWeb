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
    <div class="row g-4 align-items-center mb-4">
        <div class="col-lg-7">
            <a href="<%=request.getContextPath()%>/estudiante" class="btn btn-outline-secondary btn-sm mb-3">Volver</a>
            <h1><%=c.getNombre()%></h1>
            <p class="lead"><%=c.getDescripcion()%></p>
            <span class="badge text-bg-success"><%=c.getTipo()%></span>
        </div>
        <div class="col-lg-5 text-center">
            <img class="lesson-img" src="<%=request.getContextPath()%>/<%=c.getImagen()%>" alt="Imagen educativa de <%=c.getNombre()%>">
        </div>
    </div>

    <section class="row g-4" aria-label="Recursos multimedia">
        <% if (recursos != null) for (ResourceItem r : recursos) { %>
        <div class="col-lg-6">
            <article class="card h-100 shadow-sm">
                <div class="card-body">
                    <h2 class="h5"><%=r.getTitulo()%></h2>
                    <p><%=r.getDescripcion()%></p>
                    <% if ("MODELO3D".equals(r.getTipo())) { %>
                        <model-viewer class="model-card" src="<%=request.getContextPath()%>/<%=r.getUrl()%>" alt="<%=r.getTitulo()%>" ar ar-modes="webxr scene-viewer quick-look" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                    <% } else if ("AUDIO".equals(r.getTipo())) { %>
                        <audio controls class="w-100" aria-label="Audio educativo"><source src="<%=request.getContextPath()%>/<%=r.getUrl()%>" type="audio/wav">Su navegador no soporta audio.</audio>
                    <% } else if ("VIDEO".equals(r.getTipo())) { %>
                        <div class="ratio ratio-16x9"><iframe src="<%=r.getUrl()%>" title="Video educativo" allowfullscreen></iframe></div>
                    <% } else if ("IMAGEN".equals(r.getTipo())) { %>
                        <img class="img-fluid rounded" src="<%=request.getContextPath()%>/<%=r.getUrl()%>" alt="<%=r.getTitulo()%>">
                    <% } %>
                </div>
            </article>
        </div>
        <% } %>
    </section>
    <% } %>
</div>
<jsp:include page="includes/footer.jsp" />
