<%@ page import="model.ArticoloDAO" %>
<%@ page import="model.Articolo" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 04/07/2020
  Time: 18:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<html>
<head>
    <title>Modifica articolo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>


<%
    String idArtToEdit = (String)request.getAttribute("articoloToEdit");
    ArticoloDAO ardao = new ArticoloDAO();
    Articolo artToEdit = ardao.doRetrieveById(idArtToEdit);//titolo, desc, przz, luogo
%>


<div class="pageTitle" style="margin:10px;">
    <h1 style="margin-bottom: 50px;">Modifica articolo <%=artToEdit.getTitolo()%></h1>
</div>

<div class="rowDiv divError mg-bottom-20" id="div-error">
    <p id="error-message"></p>
</div>

<input type="hidden" value="<%=artToEdit.getIdArticolo()%>" id="inputIdArt">

<div class="colDiv">
    <div class="rowDiv baseline" id="formEditTitolo">
        <input class="focusOutline roundedInput mg-right-30" type="text" name="editTitolo" id="editTitolo" placeholder="<%=artToEdit.getTitolo()%>">
        <button id="butEditTitolo" class="btnGo" onclick="editTitolo()">Modifica titolo</button>
    </div>
    <div class="rowDiv baseline mg-top-30" id="formEditDescrizione">
        <textarea rows="10" class="focusOutline roundedInput mg-right-30" type="text" id="editDescrizione">
        <%=artToEdit.getDescrizione()%>
        </textarea>
        <button id="butEditDescrizione" class="btnGo" onclick="editDescrizione()">Modifica Descrizione</button>
    </div>
    <div class="rowDiv baseline mg-top-30" id="formEditPrezzo">
        <input class="focusOutline roundedInput mg-right-30" type="number" name="editTitolo" id="editPrezzo" placeholder="<%=artToEdit.getPrezzo()%>">
        <button id="butEditPrezzo" class="btnGo" onclick="editPrezzo()">Modifica prezzo</button>
    </div>


</div>


<script>

    var div_error = document.getElementById("div-error");
    var error_message = document.getElementById("error-message")
    div_error.style.visibility = "hidden"
    div_error.style.opacity = 0;
    div_error.style.transition = "visibility, opacity 500ms"
    var idArt = document.getElementById("inputIdArt").value;


    function editDescrizione() {
        //invio richiesta ajax per modifica descrizione
        var desc = document.getElementById("editDescrizione").value;
        $.ajax({
            url: "edit-servlet",
            type: "POST",
            data: "edit=desc"+"&idArticolo="+idArt+"&descrizione="+desc,
            processData: false,
            success: function (result) {
                console.log(result)
                if (result!="errore"){
                    document.getElementById("editDescrizione").style.borderColor = "green";
                    alert("Descrizione modificata con successo")
                }else{
                    document.getElementById("editDescrizione").style.borderColor = "red";
                    div_error.style.visibility = "visible";
                    div_error.style.opacity = 1;
                    error_message.innerText = "Errore nella modifica della descrizione"
                }
            }
        })

    }


    function editPrezzo() {
        var prezzo = document.getElementById("editPrezzo");
        if (prezzo.value==""){
            prezzo.style.borderColor = "red";
            prezzo.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Prezzo mancante"
            return;
        }else{
            if (!validateNumber(prezzo.value)){
                prezzo.style.borderColor = "red";
                prezzo.style.borderColor = "red";
                div_error.style.visibility = "visible";
                div_error.style.opacity = 1;
                error_message.innerText = "Numero di telefono non valido"
                return;
            }else{
                prezzo.style.borderColor = "green";
                //invia richiesta ajax per modifica prezzo
                $.ajax({
                    url: "edit-servlet",
                    type: "POST",
                    data: "edit=przz"+"&idArticolo="+idArt+"&prezzo="+prezzo.value,
                    processData: false,
                    success: function (result) {
                        console.log(result)
                        if (result!="errore"){
                            document.getElementById("editPrezzo").style.borderColor = "green";
                            alert("Prezzo modificato con successo")
                        }else{
                            document.getElementById("editPrezzo").style.borderColor = "red";
                            div_error.style.visibility = "visible";
                            div_error.style.opacity = 1;
                            error_message.innerText = "Errore nella modifica del prezzo"
                        }
                    }
                })
            }
        }
    }

    function editTitolo() {
        var titolo = document.getElementById("editTitolo");
        if (titolo.value==""){
            titolo.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Titolo mancante"
            return;
        }else {
            if (validateTxt(titolo.value)){
                titolo.style.borderColor = "red";
                div_error.style.visibility = "visible";
                div_error.style.opacity = 1;
                error_message.innerText = "Formato titolo non corretto"
                return;
            }else {
                titolo.style.borderColor = "green";
                //invio richiesta ajax x modifica titolo
                $.ajax({
                    url: "edit-servlet",
                    type: "POST",
                    data: "edit=ttl"+"&idArticolo="+idArt+"&titolo="+titolo.value,
                    processData: false,
                    success: function (result) {
                        console.log(result)
                        if (result!="errore"){
                            document.getElementById("editTitolo").style.borderColor = "green";
                            alert("Titolo modificato con successo")
                        }else{
                            document.getElementById("editTitolo").style.borderColor = "red";
                            div_error.style.visibility = "visible";
                            div_error.style.opacity = 1;
                            error_message.innerText = "Errore nella modifica del titolo"
                        }
                    }
                })
            }
        }
    }


    //funzione di validazione del campo titolo
    function validateTxt(txt) {
        var pattern = /(?=\W)(?=\S)/;
        return pattern.test(txt);
    }

    function validateNumber(n) {
        if (n>10000000)
            return false;
        return true
    }


</script>


<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<link rel="stylesheet" type="text/css" href="css/secondaryStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</body>
</html>
