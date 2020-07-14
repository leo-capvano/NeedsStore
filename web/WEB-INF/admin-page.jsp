<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 13/07/2020
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
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
</div>

<div class="colDiv mg-top-30" style="visibility: hidden;cursor: pointer; background: #8fd19e; padding: 10px; border-radius: 5px;" id="utenti">
</div>

<div class="colDiv mg-top-30" style="visibility: hidden;cursor: pointer; background: coral; padding: 10px; border-radius: 5px;" id="vendite">
</div>

<script>

    var utentiF = document.getElementById("utenti");
    var venditeF = document.getElementById("vendite");

    //funzione che visulaizza tutte le vendute effettuate
    function shawVendite() {
        $.ajax({
            url: "adminPage",
            type: "GET",
            data: {btnGetVendite:"btnGetVendite"},
            success: function (results) {
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
                var utenti = results;
                for (i=0; i<utenti.length; i++){
                    //console.log(utenti[i].email)
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

</script>



</body>
</html>
