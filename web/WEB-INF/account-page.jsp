<%@ page import="model.Utente" %>
<%@ page import="model.ArticoloDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Articolo" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 26/06/2020
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>

<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
    ArticoloDAO ardao = new ArticoloDAO();
    ArrayList<Articolo> articoli = ardao.doRetrieveByEmail(utenteLoggato.getEmail());
%>
<div class="pageTitle" style="margin:10px;">
    <h1 style="margin-bottom: 50px;">Informazioni sull'account</h1>
</div>

<div class="colDiv">
    <div class="rowDiv">
        <p class="pDescriptor">Nome: </p><p class="pContent">${utenteLoggato.nome}</p>
        <p style="margin-left: 70px;" class="pDescriptor">Cognome: </p><p class="pContent">${utenteLoggato.cognome}</p>
    </div>
    <div class="rowDiv">
        <p class="pDescriptor">Email: </p><p class="pContent">${utenteLoggato.email}</p>
    </div>
    <div class="rowDiv" style="margin-top: 20px;">
        <button class="btnGo">modifica password</button>
    </div>
</div>


<div class="pageTitle" style="margin:10px;">
    <h1 style="margin-bottom: 50px;">I miei annunci</h1>
</div>

<div class="rowDiv">
    //se l'arraylost è vuoto non ci sono articoli
    //altrimenti carica nel div tutti gli articoli dell'utente
</div>




<script>

</script>


<link rel="stylesheet" type="text/css" href="css/secondaryStyle.css">
</body>
</html>
