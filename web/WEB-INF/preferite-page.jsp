<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 10/07/2020
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<html>
<head>
    <title>Preferiti</title>
    <link rel="stylesheet" type="text/css" href="../css/mystyle.css">
    <link rel="stylesheet" type="text/css" href="../css/secondaryStyle.css">
</head>
<body>

<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>

<%if(utenteLoggato==null){%>
<jsp:include page="header.jsp"></jsp:include>
<%}else{%>
<jsp:include page="headerLogged.jsp"></jsp:include>
<%}%>

<div class="pageTitle">
    <h1>Annunci Preferiti</h1>
</div>

<%
    HashMap<String,String> preferiti = (HashMap<String, String>) session.getAttribute("preferiti");
    ArticoloDAO articoloDAO = new ArticoloDAO();
    AlbumDAO albumDAO = new AlbumDAO();
    if (preferiti.size()==0){%>
        <div class="pageTitle">
            <h1>Non ci sono preferiti da mostrare :(</h1>
        </div>
    <%}else{
    for (Map.Entry<String,String> entry: preferiti.entrySet()){
    String idArticolo = entry.getKey();
    Articolo a = articoloDAO.doRetrieveById(idArticolo);
    ArrayList<Album> album = albumDAO.doRetrieveByArticolo(a);
    %>
        <!-- 1article area  -->
        <div style="margin-left: 15px;">
            <div class="container" id="contenitoreArticoli">
                <div class="riga" id="divArticolo"><!-- div riga-->
                    <div>
                        <div class="imgContainer">
                            <%if(album.size()>0){%>
                            <img src="${request.contextPath}<%=album.get(0).getPath()%>" style="width: 100%;position: absolute;left: 0;top: 50%;transform: translateY(-50%);">
                            <%}else{%>
                            <img src="images/no-image.jpg" style="width: 100%;position: absolute;left: 0;top: 50%;transform: translateY(-50%);">
                            <%}%>
                        </div>
                    </div><!-- div foto-->
                    <div class="container">
                        <div>
                            <h3 class="titolo"><%=a.getTitolo()%></h3>
                            <p><%=a.getPrezzo()%> euro - Pubblicato il <%=a.getData_inserimento()%></p><br>
                            <p class="luogo"><%=a.getLuogo()%></p>
                            <div>
                                <form class="form-inline" action="toPageAcquista">
                                    <button class="btnGo" type="submit" name="idArticolo" value="<%=a.getIdArticolo()%>">Acquista</button>
                                </form>
                                <form class="inlineForm" action="remPreferite">
                                    <button class="btnGo redBtn" style="background-color: rgb(187,86,86);" name="idArticolo" value="<%=a.getIdArticolo()%>">Rimuovi dai preferiti</button>
                                </form>
                            </div>
                        </div>
                    </div><!-- div art-->
                </div>
            </div>
        </div>
        <hr>
    <%}}%>
</body>
</html>
