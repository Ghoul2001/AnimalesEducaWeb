<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<section class="hero-bio text-white">
    <div class="container py-5">
        <div class="row align-items-center g-4">
            <div class="col-lg-7">
                <span class="badge text-bg-warning mb-3">ODS 4 - Educacion de Calidad</span>
                <h1 class="display-5 fw-bold">Aprende sobre animales vertebrados e invertebrados</h1>
                <p class="lead">Explora fotografias reales, categorias educativas, modelos 3D con apariencia realista, realidad aumentada, videos, imagenes, audio y un quiz interactivo.</p>
                <div class="d-flex gap-2 flex-wrap">
                    <a class="btn btn-warning btn-lg" href="<%=request.getContextPath()%>/registro">Registrarme como estudiante</a>
                    <a class="btn btn-outline-light btn-lg" href="<%=request.getContextPath()%>/login">Iniciar sesion</a>
                </div>
            </div>
            <div class="col-lg-5 text-center">
                <img class="hero-img rounded-4 shadow-lg" src="<%=request.getContextPath()%>/assets/img/hero-animales-reales.jpg" alt="Fotografias reales de animales vertebrados e invertebrados">
            </div>
        </div>
    </div>
</section>

<section id="categorias" class="container py-5">
    <div class="text-center mb-4">
        <h2>Categorias principales</h2>
        <p class="text-muted">El sistema cumple con minimo tres categorias educativas usando fotos reales de animales.</p>
    </div>
    <div class="row g-4">
        <div class="col-md-4">
            <article class="card h-100 shadow-sm card-bio">
                <img src="<%=request.getContextPath()%>/assets/img/animales/mamiferos.jpg" class="card-img-top animal-photo" alt="Fotografia real de un leon, ejemplo de mamifero vertebrado">
                <div class="card-body"><h3 class="h5">Mamiferos</h3><p>Vertebrados con columna vertebral, pulmones y, generalmente, pelo.</p></div>
            </article>
        </div>
        <div class="col-md-4">
            <article class="card h-100 shadow-sm card-bio">
                <img src="<%=request.getContextPath()%>/assets/img/animales/aves.jpg" class="card-img-top animal-photo" alt="Fotografia real de un aguila, ejemplo de ave vertebrada">
                <div class="card-body"><h3 class="h5">Aves</h3><p>Vertebrados con plumas, pico y reproduccion por huevos.</p></div>
            </article>
        </div>
        <div class="col-md-4">
            <article class="card h-100 shadow-sm card-bio">
                <img src="<%=request.getContextPath()%>/assets/img/animales/artropodos.jpg" class="card-img-top animal-photo" alt="Fotografia real de una mariposa, ejemplo de artropodo invertebrado">
                <div class="card-body"><h3 class="h5">Artropodos</h3><p>Invertebrados con exoesqueleto y patas articuladas.</p></div>
            </article>
        </div>
    </div>
</section>

<section class="container pb-5">
    <div class="row g-4 align-items-center">
        <div class="col-lg-6">
            <h2>Modelo 3D y realidad aumentada</h2>
            <p>El sitio usa el componente <code>&lt;model-viewer&gt;</code> para visualizar modelos 3D con textura realista, activar AR en dispositivos compatibles y registrar la actividad en la bitacora.</p>
            <p class="small text-muted">En computadora se muestra el modelo 3D; en celular compatible aparece la opcion de realidad aumentada.</p>
        </div>
        <div class="col-lg-6">
            <model-viewer class="model-card" src="<%=request.getContextPath()%>/assets/models/pez_vertebrado.glb" poster="<%=request.getContextPath()%>/assets/img/animales/pez.jpg" alt="Modelo 3D de un pez vertebrado con fotografia real de referencia" ar ar-modes="webxr scene-viewer quick-look" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
        </div>
    </div>
</section>
<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
