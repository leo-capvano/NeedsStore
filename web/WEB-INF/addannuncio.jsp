<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 04/04/2020
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>Inserisci il tuo annuncio</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>


<div class="pageTitle">
    <h1 style="margin-bottom: 30px;">Inserisci un annuncio</h1>
</div>

<div class="rowDiv divError mg-bottom-20" id="div-error">
    <p id="error-message"></p>
</div>

<div class="container">
    <form method="get" action="toUploadphoto" id="addAnnuncioForm">
        <div class="rowDiv wrap">
            <div class="colDiv">
                <input type="text" class="inputText focusOutline" id="titolo" name="titolo" placeholder="titolo">
                <textarea class="inputText focusOutline" rows="5" name="descrizione" placeholder="Descrizione dell'annuncio"></textarea>
            </div>
        </div>
        <div class="rowDiv wrap" id="divSelezioneCategoria">
            <c:forEach items="${categorie}" var="categoria">
                ${categoria.nome}<input type="checkbox" checked name="boxCategorie" value="${categoria.nome}" style="margin-right: 20px;margin-bottom: 10px;cursor: pointer;">
            </c:forEach>
        </div>

        <div class="rowDiv wrap mg-bottom-20">
            <input type="text" onkeypress="suggerisciLuogo()" class="inputText" id="luogo" name="luogo" placeholder="Provincia di vendita">
            <select id="selectLuogo">

            </select>
        </div>

        <div class="rowDiv">
            <input type="number" class="inputText focusOutline" id="prezzo" name="prezzo" placeholder="Prezzo">
        </div>
    </form>
    <div class="rowDiv">
        <button type="submit" class="btnGo" onclick="validation()">AVANTI</button>
    </div>
</div>
</body>
<script>

var div_error = document.getElementById("div-error");
var error_message = document.getElementById("error-message")
div_error.style.visibility = "hidden"
div_error.style.opacity = 0;
div_error.style.transition = "visibility, opacity 500ms"

//validazione generale di tutti i campi
function validation() {

    var titolo = document.getElementById("titolo")
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
        }
    }

    var selectCategorie = document.getElementsByName("boxCategorie");
    if (validateCategorie(selectCategorie)){

    }else{
        div_error.style.visibility = "visible";
        div_error.style.opacity = 1;
        error_message.innerText = "Seleziona almeno una categoria per il tuo annuncio"
        return;
    }

    var luogo = document.getElementById("luogo");
    if (luogo.value==""){
        luogo.style.borderColor = "red";
        luogo.style.borderColor = "red";
        div_error.style.visibility = "visible";
        div_error.style.opacity = 1;
        error_message.innerText = "Luogo di vendita mancante"
        return;
    }else {
        if(!validateLuogo(luogo.value)){
            luogo.style.borderColor = "red";
            luogo.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Luogo di vendita scorretto"
            return;
        }else{
            luogo.style.borderColor = "green";
            luogo.style.borderColor = "green";
        }
    }


    var prezzo = document.getElementById("prezzo");
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
            prezzo.style.borderColor = "green";
        }
    }


    document.getElementById("addAnnuncioForm").submit();
}

function suggerisciLuogo() {
    var luogo = document.getElementById("luogo");
    var written = luogo.value;
    $.ajax({
        url: "selectProvincia",
        type: "GET",
        data: {written: written},
        success: function (result) {
            $("#selectLuogo").html("")
            for (i = 0; i<result.length; i++){
                $("#selectLuogo").append("<option value='"+result[i]+"'>"+result[i]+"</option>")
            }
        }
    })
}

function validateCategorie(s){
    ok = false;
    for (i=0; i<s.length; i++){
        if (s[i].checked==true)
            ok=true;
    }
    return ok;
}

//click sull'option della select
$("#selectLuogo").click(function () {
    $("#luogo").val($("#selectLuogo option:selected").text());
    $("#luogo").css("border-color","green");
    $("#selectLuogo").css("border-color","green");
})


//funzione di validazione del campo titolo
function validateTxt(txt) {
    var pattern = /(?=\W)(?=\S)/;
    return pattern.test(txt);
}

//per controllare se l'usr ha selezionato un luogo corretto
//verifico che sia presente nelle options della select
function validateLuogo(luogo) {
   if ($("#luogo").val().toUpperCase() == $("#selectLuogo option:selected").text().toUpperCase())
       return true;
   return false;
}

function validateNumber(n) {
    if (n>10000000)
        return false;
    return true
}

</script>
</html>
