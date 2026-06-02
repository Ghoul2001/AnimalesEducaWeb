<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5 narrow">
    <div class="card shadow-lg border-0">
        <div class="card-body p-4">
            <h1 class="h3 mb-3">Iniciar sesion</h1>
            <% if (request.getAttribute("error") != null) { %><div class="alert alert-danger"><%=request.getAttribute("error")%></div><% } %>
            <% if (request.getParameter("msg") != null) { %><div class="alert alert-info"><%=request.getParameter("msg")%></div><% } %>
            <form method="post" action="<%=request.getContextPath()%>/login" novalidate>
                <div class="mb-3">
                    <label for="email" class="form-label">Correo electronico</label>
                    <input id="email" name="email" type="email" class="form-control" required autocomplete="email">
                </div>
                <div class="mb-3">
                    <label for="clave" class="form-label">Clave</label>
                    <input id="clave" name="clave" type="password" class="form-control" required minlength="8" autocomplete="current-password">
                </div>
                <button class="btn btn-bio w-100" type="submit">Ingresar</button>
            </form>
            <hr>
            <p class="small mb-1">Usuario administrador inicial:</p>
            <p class="small"><strong>admin@animales.edu</strong> / <strong>admin1234</strong></p>
            <a href="<%=request.getContextPath()%>/registro">Crear cuenta de estudiante</a>
        </div>
    </div>
</div>
<jsp:include page="includes/footer.jsp" />
