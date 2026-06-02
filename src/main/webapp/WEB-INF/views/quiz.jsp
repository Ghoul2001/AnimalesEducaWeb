<%@ page import="java.util.*,com.animales.model.Question" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp" />
<div class="container py-5">
    <h1 class="h2">Quiz interactivo</h1>
    <p class="text-muted">Esta actividad registra la interaccion del estudiante en la bitacora del administrador.</p>
    <% if (request.getAttribute("error") != null) { %><div class="alert alert-danger"><%=request.getAttribute("error")%></div><% } %>
    <% if (request.getAttribute("resultado") != null) { %><div class="alert alert-success"><%=request.getAttribute("resultado")%></div><% } %>
    <form method="post" action="<%=request.getContextPath()%>/quiz">
        <%
            List<Question> preguntas = (List<Question>) request.getAttribute("preguntas");
            if (preguntas != null) {
                int n=1;
                for (Question q : preguntas) {
        %>
        <fieldset class="card shadow-sm mb-3">
            <div class="card-body">
                <legend class="h5"><%=n++%>. <%=q.getPregunta()%></legend>
                <div class="form-check"><input class="form-check-input" type="radio" name="p<%=q.getId()%>" id="p<%=q.getId()%>a" value="A" required><label class="form-check-label" for="p<%=q.getId()%>a"><%=q.getOpcionA()%></label></div>
                <div class="form-check"><input class="form-check-input" type="radio" name="p<%=q.getId()%>" id="p<%=q.getId()%>b" value="B"><label class="form-check-label" for="p<%=q.getId()%>b"><%=q.getOpcionB()%></label></div>
                <div class="form-check"><input class="form-check-input" type="radio" name="p<%=q.getId()%>" id="p<%=q.getId()%>c" value="C"><label class="form-check-label" for="p<%=q.getId()%>c"><%=q.getOpcionC()%></label></div>
            </div>
        </fieldset>
        <%      }
            }
        %>
        <button class="btn btn-bio btn-lg" type="submit">Enviar respuestas</button>
    </form>
</div>
<jsp:include page="includes/footer.jsp" />
