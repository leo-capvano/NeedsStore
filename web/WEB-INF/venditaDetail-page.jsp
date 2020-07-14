<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 14/07/2020
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<html>
<head>
    <title>Dettagli Vendita</title>
</head>
<body>
<%
    ArticoloDAO articoloDAO = new ArticoloDAO();
    VenditaDAO venditaDAO = new VenditaDAO();
    UtenteDAO utenteDAO = new UtenteDAO();
    AlbumDAO albumDAO = new AlbumDAO();
    String idArticoloVenduto = (String) request.getAttribute("idArticoloVenduto");

    Articolo articoloVenduto = articoloDAO.doRetrieveById(idArticoloVenduto);
    Vendita vendita = venditaDAO.doRetrieveByIdArticolo(idArticoloVenduto);
    Utente venditore = utenteDAO.doRetrieveByEmail(articoloVenduto.getEmail_vend());
    ArrayList<Album> album = albumDAO.doRetrieveByArticolo(articoloVenduto);
%>


<jsp:include page="headerLogged.jsp"></jsp:include>

<div class="pageTitle centerDiv">
    <h1 style="margin-bottom: 50px; text-transform: uppercase;">DETTAGLI VENDITA</h1>
</div>

<h3 class="chapterTitle">
    Articolo Venduto
</h3>
<div class="colDiv">
    <div class="galleryPic centerDiv" id="galleryPic">
        <%if(album!=null){
            for(int i =0; i<album.size(); i++){%>
        <div class="pics fade">
            <img src="<%=album.get(i).getPath()%>" style="width: 450px;height: 400px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;">
        </div>
        <%}%>
        <%}else{%>
        <div>
            <img src="images/no-image.jpg" style="width: 400px;height: 400px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;">
        </div>
        <%}%>
    </div>

    <div class="rowDiv centerDiv" id="navigationButtons">
        <a class="prec" onclick="scorri(-1)">&#10094;</a>
        <a class="succ" onclick="scorri(1)">&#10095;</a>
    </div>

    <h3 class="separatorTitle mg-left-30 zindex1"><p>Informazioni sull'articolo</p></h3>
    <div style="border-radius: 7px; background-color: rgba(152,222,136,0.85); z-index: 0;">
        <div class="rowDiv centerDiv baseline wrap mg-bottom-20 zindex0" id="infoArt">
            <div class="rowDiv mg-top-30">
                <div class="colDiv centerDiv">
                    <span>Pubblicato il: <%=articoloVenduto.getData_inserimento()%></span>
                    <span>Luogo: <%=articoloVenduto.getLuogo()%></span>
                    <span>Prezzo: <%=articoloVenduto.getPrezzo()%></span>
                    <span>Venduto da: <%=venditore.getEmail()%> (<%=venditore.getNome()%> <%=venditore.getCognome()%>)</span>
                </div>
            </div>
        </div>
    </div>


<h3 class="separatorTitle mg-left-30 zindex1"><p>Informazioni di vendita</p></h3>
<div style="border-radius: 7px; background-color: rgba(152,222,136,0.85); z-index: 0;">
    <div class="rowDiv centerDiv baseline wrap mg-bottom-20 zindex0" id="infoVendita">
        <div class="rowDiv mg-top-30">
            <div class="colDiv centerDiv">
                <span>Data di vendita: <%=vendita.getDataVendita()%></span>
                <span>Prezzo di vendita: <%=vendita.getPrezzo()%></span>
            </div>
        </div>
    </div>
</div>
</div>

<script>
    var galleryIndex = 0;
    showGallery(galleryIndex);

    function scorri(n) {
        galleryIndex += n;
        showGallery(galleryIndex);
    }

    function showGallery(index) {
        var pics = document.getElementsByClassName("pics");
        if (index >= pics.length){galleryIndex = 0}
        if (index < 0){galleryIndex = pics.length-1}
        for(i=0; i<pics.length; i++){
            pics[i].style.display = "none";
        }
        pics[galleryIndex].style.display = "block";
    }


</script>

</body>
</html>
