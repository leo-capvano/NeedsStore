<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 03/04/2020
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Accedi al tuo account</title>
</head>
<body>
<%
    String errorLogin = (String)request.getAttribute("errorLogin");
%>

<jsp:include page="WEB-INF/header.jsp"></jsp:include>

<div class="rowDiv divError mg-bottom-20" id="div-error">
    <p id="error-message"></p>
</div>

<div class="pageTitle">
    <h1>Accedi a Needs.store</h1>
</div>

<div class="rowDiv">
    <div class="loginContainer" id="formContainer">
        <form action="login" method="post" class="verticalForm" id="loginForm">
            <input id="email" name="email" type="email" class="focusOutline" placeholder="Email">
            <input id="pwd" name="pwd" type="password" class="focusOutline" placeholder="Password">
        </form>
        <div class="rowDiv">
            <button class="btnGo" id="btnAccedi" onclick="validateLogin()">Accedi</button>
        </div>
        <%if (errorLogin!=null){%>
        <div class="divError">
            <p>Email o password errata!</p>
        </div>
        <%}%>
    </div>
</div>


<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</body>

<script>
    //inizialmente nascondi div_error
    var div_error = document.getElementById("div-error");
    var error_message = document.getElementById("error-message")
    div_error.style.visibility = "hidden"
    div_error.style.opacity = 0;
    div_error.style.transition = "visibility, opacity 500ms";

    function validateLogin() {
        var email = document.getElementById("email");
        var pwd = document.getElementById("pwd");
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function(){
            if ((xhr.readyState==4) && (xhr.status=200)){
                if (xhr.responseText=="not ok"){
                    email.style.borderColor = "red";
                    pwd.style.borderColor = "red";
                    div_error.style.visibility = "visible";
                    div_error.style.opacity = 1;
                    error_message.innerText = "Email o password non corretti";
                }else if (xhr.responseText=="ok"){
                    document.getElementById("loginForm").submit();
                }else{
                    email.style.borderColor = "red";
                    pwd.style.borderColor = "red";
                    div_error.style.visibility = "visible";
                    div_error.style.opacity = 1;
                    error_message.innerText = "Errore interno";
                }
            }
        }
        xhr.open("POST","checkUsr",true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("email="+email.value+"&"+"pwd="+pwd.value);

    }



</script>
</html>
