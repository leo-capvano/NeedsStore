<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 13/07/2020
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Admin Page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
    <link rel="stylesheet" type="text/css" href="css/secondaryStyle.css">
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>

<div class="pageTitle">
    <h1 style="margin-bottom: 50px; text-transform: uppercase;">PAGINA DI AMMINISTRAZIONE</h1>
</div>

<div clas="rowDiv">
    <button class="btnGo" id="shawUsers" onclick="shawUsers()">Utenti</button>
    <button class="btnGo" id="shawVendite" onclick="shawVendite()">Vendite</button>
    <button class="btnGo" id="shawCategorie" onclick="shawCategorie()">Categorie</button>
</div>

<div class="colDiv mg-top-30" style="visibility: hidden;cursor: pointer; background: #8fd19e; padding: 10px; border-radius: 5px;" id="utenti">
</div>

<div class="colDiv mg-top-30" style="visibility: hidden;cursor: pointer; background: coral; padding: 10px; border-radius: 5px;" id="vendite">
</div>

<div class="colDiv mg-top-30" style="cursor: pointer; background: rgba(86,130,204,0.85); padding: 10px; border-radius: 5px;" id="categorie">
    <button onclick="addCat()" class="btnGoSecondary mg-bottom-20">Aggiungi una categoria</button>
    <form action="adminPage" style="display: none;" id="formAddCat">
        <div class="rowDiv wrap">
            <span class="mg-right-30">Nome categoria: </span><input class="inputText" type="text" name="nome" id="nomeCat"><br>
        </div>
        <div class="rowDiv wrap">
            <span class="mg-right-30">Breve descrizione: </span><textarea class="inputText" name="descrizione" rows="5" cols="20"></textarea>
        </div>
        <div class="rowDiv wrap">
            <button type="submit" name="btnAddCat" value="btnAddCat" class="btnGo">Aggiungi</button>
        </div>
    </form>
    <h2 class="chapterTitle">CATEGORIE:</h2>
    <c:forEach items="${categorie}" var="categoria">
        <div class="rowDivStart">
            <span class="mg-right-30">${categoria.nome}</span>
        </div>
    </c:forEach>
</div>

<script>

    var utentiF = document.getElementById("utenti");
    var venditeF = document.getElementById("vendite");
    var categorieF = document.getElementById("categorie");

    //funzione che visulaizza tutte le vendute effettuate
    function shawVendite() {
        $.ajax({
            url: "adminPage",
            type: "GET",
            data: {btnGetVendite:"btnGetVendite"},
            success: function (results) {
                utentiF.innerHTML="";
                venditeF.innerHTML="";
                console.log(results);
                venditeF.style.visibility="visible";
                var vendite = results;
                for(i=0; i<vendite.length; i++) {
                    var articolo = document.createElement("div");
                    articolo.className = "rowDivStart";
                    var formF = document.createElement("form");
                    formF.action = "venditaDetail";

                    var titoloVendutoF = document.createElement("button");
                    titoloVendutoF.type = "submit";
                    titoloVendutoF.name = "idArticoloVenduto";
                    titoloVendutoF.className = "btnGo"
                    titoloVendutoF.value = vendite[i].idArticolo;
                    titoloVendutoF.innerHTML = vendite[i].titolo;

                    formF.appendChild(titoloVendutoF);
                    articolo.appendChild(formF);
                    venditeF.appendChild(articolo);
                }
            }
        })
    }



    //funzione che restituisce la lista di utenti a video
    function shawUsers() {
        $.ajax({
            url:"adminPage",
            type: "GET",
            data: {btnGetUsers:"btnGetUsers"},
            success: function (results) {
                utentiF.innerHTML="";
                venditeF.innerHTML="";
                utentiF.style.visibility="visible";
                var utenti = results;
                for (i=0; i<utenti.length; i++){
                    console.log(utenti[i].email)
                    var utente = document.createElement("div");
                    utente.className = "rowDivStart";
                    var formF = document.createElement("form");
                    formF.action = "userDetail";

                    var emailF = document.createElement("button");
                    emailF.type = "submit";
                    emailF.name="email";
                    emailF.className="btnGo"
                    emailF.value=utenti[i].email;
                    emailF.innerHTML = utenti[i].email;

                    formF.appendChild(emailF);
                    utente.appendChild(formF);
                    utentiF.appendChild(utente);

                }
            }
        })
    }

    //funzione che restituisce la lista di categorie a video
    function shawCategorie() {
        $("#categorie").css("visibility","visible");
    }

    //funzione che mostra a schermo dei campi di testo per l'aggiunta di una
    //nuova categoria di articoli
    function addCat() {
        if (document.getElementById("formAddCat").style.display=="none"){
            document.getElementById("formAddCat").style.display="block";
        }else{
            document.getElementById("formAddCat").style.display="none";
        }
    }


</script>



</body>
</html>
