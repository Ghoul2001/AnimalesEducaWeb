<%@ page import="java.util.*,com.animales.model.User,com.animales.model.LogEntry" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5">
    <h1 class="h2 mb-3">Panel administrador</h1>
    <p class="text-muted">Gestion de usuarios, bloqueo de acceso y revision de bitacora.</p>
    <% if (request.getAttribute("error") != null) { %><div class="alert alert-danger"><%=request.getAttribute("error")%></div><% } %>
    <% if (request.getAttribute("ok") != null) { %><div class="alert alert-success"><%=request.getAttribute("ok")%></div><% } %>

    <section class="card shadow-sm mb-4">
        <div class="card-body">
            <h2 class="h4">Ingresar nuevo usuario</h2>
            <form method="post" action="<%=request.getContextPath()%>/admin" class="row g-3">
                <input type="hidden" name="action" value="crear">
                <div class="col-md-3"><label class="form-label" for="nombre">Nombre</label><input id="nombre" name="nombre" class="form-control" required></div>
                <div class="col-md-3"><label class="form-label" for="email">Correo</label><input id="email" name="email" type="email" class="form-control" required></div>
                <div class="col-md-2"><label class="form-label" for="clave">Clave</label><input id="clave" name="clave" type="password" minlength="8" class="form-control" required></div>
                <div class="col-md-2"><label class="form-label" for="rol">Rol</label><select id="rol" name="rol" class="form-select"><option>ESTUDIANTE</option><option>ADMIN</option></select></div>
                <div class="col-md-2 d-flex align-items-end"><button class="btn btn-bio w-100">Guardar</button></div>
            </form>
        </div>
    </section>

    <section class="card shadow-sm mb-4">
        <div class="card-body">
            <h2 class="h4">Usuarios registrados</h2>
            <div class="table-responsive">
                <table class="table table-striped align-middle">
                    <thead><tr><th>ID</th><th>Nombre</th><th>Email</th><th>Rol</th><th>Estado</th><th>Acciones</th></tr></thead>
                    <tbody>
                    <%
                        List<User> usuarios = (List<User>) request.getAttribute("usuarios");
                        if (usuarios != null) for (User u : usuarios) {
                    %>
                        <tr>
                            <td><%=u.getId()%></td><td><%=u.getNombre()%></td><td><%=u.getEmail()%></td><td><%=u.getRol()%></td><td><%=u.getEstado()%></td>
                            <td class="d-flex gap-2 flex-wrap">
                                <form method="post" action="<%=request.getContextPath()%>/admin"><input type="hidden" name="id" value="<%=u.getId()%>"><input type="hidden" name="action" value="<%="ACTIVO".equals(u.getEstado()) ? "bloquear" : "activar"%>"><button class="btn btn-sm <%="ACTIVO".equals(u.getEstado()) ? "btn-outline-danger" : "btn-outline-success"%>"><%="ACTIVO".equals(u.getEstado()) ? "Bloquear" : "Activar"%></button></form>
                                <form method="post" action="<%=request.getContextPath()%>/admin" class="d-flex gap-1"><input type="hidden" name="id" value="<%=u.getId()%>"><input type="hidden" name="action" value="rol"><select name="rol" class="form-select form-select-sm"><option <%= "ESTUDIANTE".equals(u.getRol()) ? "selected" : "" %>>ESTUDIANTE</option><option <%= "ADMIN".equals(u.getRol()) ? "selected" : "" %>>ADMIN</option></select><button class="btn btn-sm btn-outline-primary">Actualizar</button></form>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <section class="card shadow-sm">
        <div class="card-body">
            <h2 class="h4">Bitacora de actividad</h2>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead><tr><th>Fecha</th><th>Usuario</th><th>Accion</th><th>Modulo</th><th>Descripcion</th><th>Revision</th><th>Accion</th></tr></thead>
                    <tbody>
                    <%
                        List<LogEntry> logs = (List<LogEntry>) request.getAttribute("bitacora");
                        if (logs != null) for (LogEntry l : logs) {
                    %>
                        <tr>
                            <td><%=l.getFecha()%></td><td><%=l.getUsuario()%></td><td><%=l.getAccion()%></td><td><%=l.getModulo()%></td><td><%=l.getDescripcion()%></td><td><%=l.getEstadoRevision()%></td>
                            <td>
                                <% if (!"APROBADO".equals(l.getEstadoRevision())) { %>
                                <form method="post" action="<%=request.getContextPath()%>/admin"><input type="hidden" name="id" value="<%=l.getId()%>"><input type="hidden" name="action" value="aprobar"><button class="btn btn-sm btn-success">Aprobar</button></form>
                                <% } else { %><span class="badge text-bg-success">OK</span><% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</div>
<jsp:include page="includes/footer.jsp" />
