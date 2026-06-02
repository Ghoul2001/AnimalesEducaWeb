<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5 narrow">
    <div class="card shadow-lg border-0">
        <div class="card-body p-4">
            <h1 class="h3 mb-3">Registro de estudiante</h1>
            <p class="text-muted">El usuario invitado puede revisar esta pagina y registrar un estudiante nuevo.</p>
            <% if (request.getAttribute("error") != null) { %><div class="alert alert-danger"><%=request.getAttribute("error")%></div><% } %>
            <% if (request.getAttribute("ok") != null) { %><div class="alert alert-success"><%=request.getAttribute("ok")%></div><% } %>
            <form method="post" action="<%=request.getContextPath()%>/registro" id="registroForm">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre completo</label>
                    <input id="nombre" name="nombre" type="text" class="form-control" required minlength="3" autocomplete="name">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Correo valido</label>
                    <input id="email" name="email" type="email" class="form-control" required autocomplete="email">
                </div>
                <div class="mb-3">
                    <label for="clave" class="form-label">Clave minimo 8 caracteres</label>
                    <input id="clave" name="clave" type="password" class="form-control" required minlength="8" autocomplete="new-password">
                    <div id="ayudaClave" class="form-text">Ejemplo: estudiante123</div>
                </div>
                <button class="btn btn-bio w-100" type="submit">Registrar estudiante</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="includes/footer.jsp" />
