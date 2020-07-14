<%@ page import="model.Utente" %>
<%@ page import="model.UtenteDAO" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 13/07/2020
  Time: 23:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<html>
<head>
    <title>Dettagli Utente ${email}</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
    <link rel="stylesheet" type="text/css" href="css/secondaryStyle.css">
</head>
<body>

<%
    UtenteDAO utenteDAO = new UtenteDAO();
    Utente userDetail = (Utente)utenteDAO.doRetrieveByEmail((String)request.getAttribute("email"));
%>

<jsp:include page="headerLogged.jsp"></jsp:include>

<div class="pageTitle centerDiv">
    <h1 style="margin-bottom: 50px; text-transform: uppercase;">DETTAGLI UTENTE</h1>
</div>


<div class="colDiv mg-left-30" id="dettagliUtente">
    <div class="rowDivStart">
        <span class="bold">EMAIL: </span><span><%=userDetail.getEmail()%></span>
    </div>
    <div class="rowDivStart mg-top-30">
        <span class="bold">NOME: </span><span class="mg-right-30"><%=userDetail.getNome()%></span>
        <span class="bold">COGNOME: </span><span><%=userDetail.getCognome()%></span>
    </div>
    <div class="rowDivStart mg-top-30">
        <span class="bold">TELEFONO: </span><span class="mg-right-30"><%=userDetail.getTelefono()%></span>
        <span class="bold">ADMIN: </span><span><%=userDetail.isAdmin()%></span>
    </div>
</div>
<hr>

<h3 class="chapterTitle">MODIFICA UTENTE</h3>

<div class="colDiv mg-left-30">
    <form action="editUser">
        Modifica nome: <input type="text" name="nome">
        <input type="hidden" name="emailUtente" value="<%=userDetail.getEmail()%>" class="inputText focusOutline">
        <button type="submit" class="btnGo">Modifica</button>
    </form>
    <form action="editUser">
        Modifica cognome: <input type="text" name="cognome">
        <input type="hidden" name="emailUtente" value="<%=userDetail.getEmail()%>" class="inputText focusOutline">
        <button type="submit" class="btnGo">Modifica</button>
    </form>
    <form action="editUser">
        Modifica numero di telefono: <input type="number" name="telefono">
        <input type="hidden" name="emailUtente" value="<%=userDetail.getEmail()%>" class="inputText focusOutline">
        <button type="submit" class="btnGo">Modifica</button>
    </form>
</div>

</body>
</html>
