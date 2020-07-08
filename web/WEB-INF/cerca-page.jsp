<%@ page import="model.Utente" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 18/05/2020
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Carca Annunci</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

    <%
        Utente utenteLoggato = (Utente)request.getSession().getAttribute("utenteLoggato");
    %>
    <%if(utenteLoggato==null){%>
        <jsp:include page="header.jsp"></jsp:include>
    <%}else{%>
        <jsp:include page="headerLogged.jsp"></jsp:include>
    <%}%>

    <div class="pageTitle">
        <h3 align="center">CERCA ANNUNCI</h3>
    </div>

    <div class="centerDiv mg-top-30">
        <input type="text" id="titoloAnnuncio" class="inputText focusOutline" name="titoloAnnuncio" placeholder="Titolo annuncio" onkeypress="cerca()">
        <button type="button" name="btnCerca" class="btnGo" onclick="cerca()">Cerca</button>
    </div>

    <div id="containerForResults" class="colDiv">
        <div id="primoDiv"></div>
    </div>
</body>
<script>

    function articoloNotFound() {
        container = document.getElementById("containerForResults")
        var errorMsg = document.createElement("h2")
        errorMsg.innerHTML="Nessun articolo trovato"
        container.appendChild(errorMsg)
    }

    function loadIntoPage(a){
        container = document.getElementById("containerForResults")
        var riga = document.createElement("div");

        var divArticolo = document.createElement("div");
        divArticolo.className = "rowDiv wrap space-bt m10";
        divArticolo.innerHTML += "<div class='colDiv'><h3 class='chapterTitle'>"+a.titolo+"</h3><p>Descrizione: "+a.descrizione +
        "</p><p>Venditore: "+a.email_vend + "</p><p>Prezzo: "+a.prezzo + " euro</p></div>";

        var inputForm = document.createElement("form");
        inputForm.action = "toPageAcquista"
        inputForm.innerHTML += "<input type='hidden' name='idArticolo' value='"+a.idArticolo+"'>";
        inputForm.innerHTML += "<button type='submit' class='btnGo mg-top-30 m10'>Vedi annuncio</button>";
        divArticolo.appendChild(inputForm);

        var primoDiv = document.getElementById("primoDiv")
        riga.appendChild(divArticolo)
        riga.innerHTML += "<hr>"
        container.insertBefore(riga, primoDiv)
    }

    function cerca() {
        var written = document.getElementById("titoloAnnuncio").value;

        //rimuovi vecchi risultati di ricerca
        var container = document.getElementById("containerForResults")
        container.innerHTML = "";

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function(){
          if (xhr.readyState==4 && xhr.status==200){
              //get response text
              var articoli = JSON.parse(xhr.responseText);
              console.log(articoli)
              //alert(resp[0].titolo)
              if (articoli[0].idArticolo=="empty"){
                  articoloNotFound()
              }else{
                  for(i=0; i<articoli.length; i++){
                      loadIntoPage(articoli[i])
                  }
              }
          }
        };
        xhr.open("get","cercaServlet?written="+written,true);
        xhr.send();

    }
</script>
</html>
