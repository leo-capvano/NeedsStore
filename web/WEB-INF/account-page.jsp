<%@ page import="model.Utente" %><%--
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
%>
<div class="pageTitle" style="margin:10px;">
    <h1>Informazioni sull'account</h1>
</div>

<div class="colDiv">
    <div class="rowDiv">
        <p class="pDescriptor">Nome: </p><p>${utenteLoggato.nome}</p>
        <p>Cognome: </p><p>${utenteLoggato.cognome}</p>
    </div>
    <div class="rowDiv">
        <p>Email: </p><p>${utenteLoggato.email}</p>
    </div>
    <div class="rowDiv">
        <button class="btnGo">modifica password</button>
    </div>
</div>




<script>

</script>


<link rel="stylesheet" type="text/css" href="css/mystyle.css">
</body>
</html>
