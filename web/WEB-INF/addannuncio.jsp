<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 04/04/2020
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>

<html>
<head>
    <title>Inserisci il tuo annuncio</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>

<div class="pageTitle">
    <h1>Inserisci un annuncio</h1>
</div>


<div class="container">
    <form method="get" action="toUploadphoto" id="addAnnuncioForm">
        <div class="rowDiv wrap">
            <div class="colDiv">
                <input type="text" class="inputText focusOutline" id="titolo" name="titolo" placeholder="titolo">
                <textarea class="inputText focusOutline" rows="5" name="descrizione" placeholder="Descrizione dell'annuncio"></textarea>
            </div>
        </div>

        <div class="rowDiv wrap mg-bottom-20">
            <input type="text" onkeydown="suggerisciLuogo()" class="inputText" id="luogo" name="luogo" placeholder="Provincia di vendita">
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

//var div_error = document.getElementById("div-error");
//div_error.style.visibility = "hidden"
//div_error.style.opacity = 0;
//div_error.style.transition = "visibility, opacity 500ms"

function validation() {
    var ok = true;
    var titolo = document.getElementById("titolo")
    if (validateTxt(titolo.value)){
        titolo.style.borderColor = "red";
        div_error.style.visibility = "visible";
        div_error.style.opacity = 1;
        ok = false;
    }else {
        titolo.style.borderColor = "green";
        ok = true;
    }

    var luogo = document.getElementById("luogo");
    if(!validateLuogo(luogo.value)){
        luogo.style.borderColor = "red";
        luogo.style.borderColor = "red";
        div_error.style.visibility = "visible";
        div_error.style.opacity = 1;
        ok = false;
    }else{
        luogo.style.borderColor = "green";
        luogo.style.borderColor = "green";
        ok = true;
    }

    var pwd1 = document.getElementById("pwd1");
    var pwd2 = document.getElementById("pwd2");
    if(!validatePwd(pwd1.value,pwd2.value)){
        pwd1.style.borderColor = "red";
        pwd2.style.borderColor = "red";
        div_error.style.visibility = "visible";
        div_error.style.opacity = 1;
        ok = false;
    }else{
        pwd1.style.borderColor = "green";
        pwd2.style.borderColor = "green";
        ok = true;
    }

    var number = document.getElementById("telefono");
    if (number.value!=""){
        if (!validateNumber(number.value)){
            number.style.borderColor = "red";
            number.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            ok = false;
        }else{
            number.style.borderColor = "green";
            number.style.borderColor = "green";
            ok = true;
        }
    }

    if (ok){
        document.getElementById("registrationForm").submit();
    }

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

$("#selectLuogo").click(function () {
    $("#luogo").val($("#selectLuogo option:selected").text());
    $("#luogo").css("border-color","green");
    $("#selectLuogo").css("border-color","green");
})



function validateTxt(txt) {
    var pattern = /\W+/;
    return pattern.test(txt);
}

</script>
</html>
