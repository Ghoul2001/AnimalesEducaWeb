<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5">
    <div class="row align-items-center g-4 mb-4">
        <div class="col-lg-8">
            <span class="badge text-bg-success mb-2">Actividad interactiva</span>
            <h1 class="h2">Proyeccion 3D: observa, compara e identifica</h1>
            <p class="lead mb-0">Gira los modelos 3D, observa sus estructuras y responde si pertenecen al grupo de vertebrados o invertebrados.</p>
        </div>
        <div class="col-lg-4 text-lg-end">
            <a class="btn btn-outline-success" href="<%=request.getContextPath()%>/estudiante">Volver al panel estudiante</a>
        </div>
    </div>

    <% if (request.getAttribute("resultado") != null) { %>
        <div class="alert alert-success" role="alert"><%=request.getAttribute("resultado")%></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger" role="alert"><%=request.getAttribute("error")%></div>
    <% } %>

    <section class="card shadow-sm border-0 mb-4" aria-labelledby="instrucciones3d">
        <div class="card-body">
            <h2 id="instrucciones3d" class="h4">Instrucciones de la actividad</h2>
            <ol class="mb-0">
                <li>Usa el mouse o el dedo para rotar cada modelo 3D.</li>
                <li>Acerca o aleja el modelo para observar sus partes principales.</li>
                <li>En un celular compatible, presiona el icono de realidad aumentada para proyectarlo en tu entorno.</li>
                <li>Completa el formulario y registra tu respuesta. La accion quedara guardada en la bitacora del administrador.</li>
            </ol>
        </div>
    </section>

    <div class="row g-4 mb-4">
        <div class="col-lg-6">
            <article class="card h-100 shadow-sm card-bio">
                <div class="card-body">
                    <h2 class="h4">Modelo A: Pez</h2>
                    <p>Representa un animal vertebrado porque posee estructura interna y columna vertebral.</p>
                    <model-viewer class="model-card model-card-large" src="<%=request.getContextPath()%>/assets/models/pez_vertebrado.glb" alt="Modelo 3D de un pez vertebrado" ar ar-modes="webxr scene-viewer quick-look" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                    <p class="small text-muted mt-2">Descripcion accesible: pez con cuerpo alargado, aletas y estructura interna propia de un vertebrado.</p>
                </div>
            </article>
        </div>
        <div class="col-lg-6">
            <article class="card h-100 shadow-sm card-bio">
                <div class="card-body">
                    <h2 class="h4">Modelo B: Mariposa</h2>
                    <p>Representa un animal invertebrado porque no posee columna vertebral y cuenta con exoesqueleto.</p>
                    <model-viewer class="model-card model-card-large" src="<%=request.getContextPath()%>/assets/models/mariposa_invertebrado.glb" alt="Modelo 3D de una mariposa invertebrada" ar ar-modes="webxr scene-viewer quick-look" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                    <p class="small text-muted mt-2">Descripcion accesible: mariposa con alas, antenas, cuerpo segmentado y exoesqueleto.</p>
                </div>
            </article>
        </div>
    </div>

    <section class="card shadow-sm border-0" aria-labelledby="form3d">
        <div class="card-body">
            <h2 id="form3d" class="h4">Registro de observacion 3D</h2>
            <p class="text-muted">Selecciona un modelo observado y responde segun lo aprendido.</p>
            <form method="post" action="<%=request.getContextPath()%>/proyeccion3d" class="row g-3">
                <div class="col-md-4">
                    <label for="modelo" class="form-label">Modelo observado</label>
                    <select id="modelo" name="modelo" class="form-select" required>
                        <option value="">Seleccione...</option>
                        <option value="PEZ">Modelo A - Pez</option>
                        <option value="MARIPOSA">Modelo B - Mariposa</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="tipo" class="form-label">Tipo de animal</label>
                    <select id="tipo" name="tipo" class="form-select" required>
                        <option value="">Seleccione...</option>
                        <option value="VERTEBRADO">Vertebrado</option>
                        <option value="INVERTEBRADO">Invertebrado</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="estructura" class="form-label">Estructura principal observada</label>
                    <select id="estructura" name="estructura" class="form-select" required>
                        <option value="">Seleccione...</option>
                        <option value="COLUMNA">Columna vertebral</option>
                        <option value="EXOESQUELETO">Exoesqueleto</option>
                    </select>
                </div>
                <div class="col-12">
                    <label for="observacion" class="form-label">Observacion del estudiante</label>
                    <textarea id="observacion" name="observacion" rows="4" class="form-control" maxlength="300" required aria-describedby="ayudaObservacion" placeholder="Ejemplo: observe aletas, alas, patas articuladas o ausencia/presencia de columna vertebral."></textarea>
                    <div id="ayudaObservacion" class="form-text">Escribe una explicacion breve. Maximo 300 caracteres.</div>
                </div>
                <div class="col-12 d-flex gap-2 flex-wrap">
                    <button class="btn btn-bio" type="submit">Registrar actividad 3D</button>
                    <a class="btn btn-warning" href="<%=request.getContextPath()%>/quiz">Continuar al quiz</a>
                </div>
            </form>
        </div>
    </section>
</div>
<jsp:include page="includes/footer.jsp" />
