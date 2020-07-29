<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 12/04/2020
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page errorPage="/errorPage.jsp" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Acquista - Needs.store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>



<%
    Articolo articolo = (Articolo) request.getAttribute("articolo");
    ArrayList<Album> album = (ArrayList<Album>) request.getAttribute("album");
    UtenteDAO udao = new UtenteDAO();
    Utente venditore = udao.doRetrieveByEmail(articolo.getEmail_vend());
    HashMap<String,String> preferiti = (HashMap<String, String>) session.getAttribute("preferiti");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
    CategoriaDAO categoriaDAO = new CategoriaDAO();
    ArticoloCategoriaDAO articoloCategoriaDAO = new ArticoloCategoriaDAO();
    //recupero le categorie di questo articolo
    ArrayList<ArticoloCategoria> articoloCategorie = articoloCategoriaDAO.doRetrieveByIdArticolo(articolo.getIdArticolo());
    ArrayList<Categoria> categorie = new ArrayList<>();
    for (ArticoloCategoria a: articoloCategorie){
        categorie.add(categoriaDAO.doRetrieveById(a.getIdCategoria()));
    }
    pageContext.setAttribute("categorieCorrenti", categorie);
%>

<%if(utenteLoggato!=null){%>
    <jsp:include page="headerLogged.jsp"></jsp:include>
<%}else{%>
    <jsp:include page="header.jsp"></jsp:include>
<%}%>

<div class="pageTitle">
    <h1 style="margin-bottom: 50px; text-transform: uppercase;"><c:if test="${articolo.venduto==false}">ACQUISTA</c:if> <%=articolo.getTitolo()%></h1>
</div>

<div class="rowDivStart wrap">
    <c:forEach items="${categorieCorrenti}" var="categoria">
        <span style="display: block; background-color: rgba(184,180,185,0.85); border-radius: 15px;padding: 10px;">${categoria.nome}</span>
    </c:forEach>
</div>

<div class="colDiv">
    <div class="galleryPic centerDiv" id="galleryPic">
        <%if(album!=null){
            for(int i =0; i<album.size(); i++){%>
                <div class="pics fade">
                    <img src="<%=album.get(i).getPath()%>" class="imgContainer">
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

    <h3 class="separatorTitle mg-left-30 zindex1"><p>Contatti</p></h3>
    <div style="border-radius: 7px; background-color: rgba(152,222,136,0.85); z-index: 0;">
        <div class="rowDiv centerDiv baseline wrap mg-bottom-20 zindex0" id="contatti">
            <div class="rowDiv mg-top-30">
                <%if (venditore.getTelefono()!=null){%>
                <div class="colDiv centerDiv">
                    <button class="btnGo" id="contattaSms" onclick="smscontact()">Invia un SMS</button>
                    <p id="telefono" style="visibility: hidden;opacity: 0;transition: visibility, opacity 500ms;" class="m10"><%=venditore.getTelefono()%></p>
                    <a style="visibility: hidden;opacity: 0;transition: visibility, opacity 500ms;" id="aWhatsapp" href="https://wa.me/15551234567?text=Ciao%20<%=venditore.getNome()%>%20ti%20contatto%20per%20il%20tuo%20annuncio%20su%20Needs.store:%20<%=articolo.getTitolo()%>">
                        <button id="whatsapp" class="btnGo w100">Messaggia su whatsapp</button>
                    </a>

                    <%if ((utenteLoggato!=null)&&(articolo.isVenduto()==false)){%>
                    <form action="addPreferite" class="inlineForm mg-top-30">
                        <button class="btnGo redBtn" style="background-color: rgb(187,86,86);" name="idArticolo" onclick="addPreferite(this)" value="<%=articolo.getIdArticolo()%>">Aggiungi ai preferiti</button>
                    </form>
                    <%}%>

                </div>
                <%}%>
            </div>
            <div class="rowDiv mg-top-30">
                <button class="btnGo" id="contattaEmail" onclick="emailcontact()">Invia una e-mail</button>
                <p id="email" class="mg-left-30" style="visibility: hidden;"><%=venditore.getEmail()%></p>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

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

    function emailcontact() {
        var email = document.getElementById("email");
        if (email.style.visibility=="hidden"){
            email.style.visibility ="visible";
            email.style.opacity = "1";
        }else{
            email.style.visibility ="hidden";
            email.style.opacity = "0";
        }
    }

    function smscontact(){
        var telefono = document.getElementById("telefono");
        var whatsappBtn = document.getElementById("aWhatsapp");
        if (telefono.style.visibility=="hidden"){
            telefono.style.visibility ="visible";
            telefono.style.opacity = "1";
            whatsappBtn.style.visibility = "visible";
            whatsappBtn.style.opacity = "1";
        }else{
            telefono.style.visibility ="hidden";
            telefono.style.opacity = "0";
            whatsappBtn.style.visibility = "hidden";
            whatsappBtn.style.opacity = "0";
        }
    }

</script>
<link rel="stylesheet" type="text/css" href="css/mystyle.css">
</body>
</html>
