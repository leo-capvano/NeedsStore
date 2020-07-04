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

<div class="colDiv wrap">
    <div class="rowDiv" id="infoAccountDiv">
        <div class="rowDivStart"><p style="margin-right: 70px;" class="pDescriptor">Nome: </p><p class="pContent">${utenteLoggato.nome}</p></div>
        <div class="rowDivStart"><p class="pDescriptor">Cognome: </p><p class="pContent">${utenteLoggato.cognome}</p></div>
    </div>
    <div class="rowDiv">
        <p class="pDescriptor">Email: </p><p class="pContent">${utenteLoggato.email}</p>
    </div>
    <div class="rowDiv" style="margin-top: 20px;">
        <button class="btnGo">modifica password</button>
    </div>
</div>

<div class="pageTitle" style="margin:30px 10px; border: 1px solid green; border-radius: 5px;">
    <h1 style="margin-bottom: 50px;">I miei annunci</h1>
</div>

<div>
    <%for(Articolo a : articoli){%>
    <!-- 1article area  -->
    <div class="rowDivStart">
            <div class="rowDivStart mg-left-30" id="divArticolo"><!-- div riga-->
                <div class="container">
                    <div>
                        <h3 class="titolo"><%=a.getTitolo()%></h3>
                        <p><%=a.getPrezzo()%> euro - Pubblicato il <%=a.getData_inserimento()%></p><br>
                        <p class="luogo"><%=a.getLuogo()%></p>
                        <div>
                            <form class="inlineForm" action="toPageAcquista">
                                <button class="btnGo" type="submit" name="idArticolo" value="<%=a.getIdArticolo()%>">Dettagli</button>
                            </form>
                            <form class="inlineForm mg-left-30" action="toModificaArt">
                                <button class="btnGo" name="modificaArt" id="modificaArt" type="submit" value="<%=a.getIdArticolo()%>">Modifica articolo</button>
                            </form>
                        </div>
                    </div>
                </div><!-- div art-->
            </div>
    </div>
    <hr>
    <%}%>
</div>




<script>

</script>

<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<link rel="stylesheet" type="text/css" href="css/secondaryStyle.css">
</body>
</html>
