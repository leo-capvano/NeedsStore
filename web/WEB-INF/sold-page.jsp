<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 09/07/2020
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp"%>
<html>
<head>
    <title>Vendite ${utenteLoggato.nome}</title>
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>


<div class="pageTitle" style="margin:10px;">
    <h1 style="margin-bottom: 50px;">Articoli venduti</h1>
</div>

<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
    if (utenteLoggato==null){
        throw new GenericException("Non sei autorizzato a visualizzare questa pagina");
    }
    ArrayList<Vendita> vendite = (ArrayList<Vendita>) request.getAttribute("vendite");
    ArticoloDAO articoloDAO = new ArticoloDAO();
    for (Vendita v : vendite){
        Articolo artVenduto = articoloDAO.doRetrieveById(v.getIdArticolo());
%>

<div class="rowDivStart baseline">
    <h3><%=artVenduto.getTitolo()%></h3>
    <p class="mg-left-30">Venduto il <%=v.getDataVendita()%> per <%=v.getPrezzo()%></p>
    <form class="inlineForm" action="toPageAcquista">
        <button type="submit" class="btnGo mg-left-30" name="idArticolo" value="<%=artVenduto.getIdArticolo()%>">Dettagli Articolo</button>
    </form>
</div>
<hr>

<%}%>
</body>
</html>
