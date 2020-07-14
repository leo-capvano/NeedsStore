<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 03/04/2020
  Time: 22:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<html>
<head>
    <title>Registati</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<jsp:include page="WEB-INF/header.jsp"></jsp:include>

<div class="pageTitle">
    <h1 style="margin-bottom: 30px;">Registrati</h1>
</div>

<div class="rowDiv divError mg-bottom-20" id="div-error">
    <p id="error-message"></p>
</div>

<div class="container">
    <form method="post" action="registration-servlet" class="verticalForm" id="registrationForm">
        <div class="rowDiv wrap">
            <input type="text" class="form-control" id="nome" name="nome" placeholder="Nome">
            <input type="text" class="form-control" id="cognome" name="cognome" placeholder="Cognome">
        </div>
        <div class="rowDiv wrap">
            <input type="text" class="form-control" id="email1" name="email1" placeholder="Email">
            <input type="text" class="form-control" id="email2" name="email2" placeholder="Conferma email">
        </div>
        <div class="colDiv">
            <div class="rowDiv">
                <button class="btnGoSecondary m10" type="button" onclick="showpwd()">Mostra password</button>
                <input type="password" id="pwd1" name="pwd1" placeholder="Password">
            </div>
            <div class="rowDiv">
                <button class="btnGoSecondary m10" type="button" onclick="showpwd()">Mostra password</button>
                <input type="password" id="pwd2" name="pwd2" placeholder="Conferma password">
            </div>
        </div>
        <div class="rowDiv">
            <input type="number" id="telefono" name="telefono" placeholder="Numero di telefono">
        </div>
    </form>
    <div class="rowDiv">
        <button class="btnGo" onclick="validation()" id="submitBtn">REGISTRATI</button>
    </div>
</div>


<script>
    var div_error = document.getElementById("div-error");
    var error_message = document.getElementById("error-message")
    div_error.style.visibility = "hidden"
    div_error.style.opacity = 0;
    div_error.style.transition = "visibility, opacity 500ms"


    function showpwd() {
        x = document.getElementById("pwd1")
        y = document.getElementById("pwd2")
        if (x.type=="password"){
            x.type = "text";
            y.type="text";
        }
        else {
            x.type = "password";
            y.type = "password";
        }

    }

    function validation() {
        var nome = document.getElementById("nome")
        if (!validateTxt(nome.value)){
            nome.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Formato nome non corretto"
            return;
        }else {
            nome.style.borderColor = "green";
        }

        var cognome = document.getElementById("cognome")
        if (!validateTxt(cognome.value)){
            cognome.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Formato cognome non corretto"
            return;
        }else {
            cognome.style.borderColor = "green";
        }

        var email1 = document.getElementById("email1");
        var email2 = document.getElementById("email2");
        if(!validateEmail(email1.value,email2.value)){
            email1.style.borderColor = "red";
            email2.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Email non corrispondenti o scorrette"
            return;
        }else{
            email1.style.borderColor = "green";
            email2.style.borderColor = "green";
        }

        var pwd1 = document.getElementById("pwd1");
        var pwd2 = document.getElementById("pwd2");
        if(!validatePwd(pwd1.value,pwd2.value)){
            pwd1.style.borderColor = "red";
            pwd2.style.borderColor = "red";
            div_error.style.visibility = "visible";
            div_error.style.opacity = 1;
            error_message.innerText = "Password non corrispondenti o di lunghezza inferiore a 8 caratteri"
            return;
        }else{
            pwd1.style.borderColor = "green";
            pwd2.style.borderColor = "green";
        }

        var number = document.getElementById("telefono");
        if (number.value!=""){
            if (!validateNumber(number.value)){
                number.style.borderColor = "red";
                number.style.borderColor = "red";
                div_error.style.visibility = "visible";
                div_error.style.opacity = 1;
                error_message.innerText = "Formato numero di telefono non corretto"
                return;
            }else{
                number.style.borderColor = "green";
                number.style.borderColor = "green";
            }
        }
         document.getElementById("registrationForm").submit();
    }

    function validateNumber(number) {
        var pattern = /((3[1-6][0-9]))(\d{7})/;
        return pattern.test(number) && number.length==10;
    }

    function validatePwd(pwd1,pwd2) {
        if ((pwd1.length>=8) && (pwd1==pwd2))
            return true;
        return false;
    }

    function validateEmail(e1,e2){
        var pattern = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;
        if(pattern.test(e1) && (e1.indexOf(' ')<0) && (e1==e2) && (!emailAlreadyExists(e1)))
            return true;
        return false;
    }

    function emailAlreadyExists(email) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if(xhr.readyState==4 && xhr.status == 200){
                console.log(xhr.responseText)
                if (xhr.responseText=="nonesiste")
                    console.log(xhr.responseText)
            }
        }
        xhr.open("get","email-already-exists?email="+email,false)
        xhr.send();
    }

    function validateTxt(txt){
        var pattern = /[A-Za-z]+/;
        return pattern.test(txt);
    }

</script>
</body>
</html>
