<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 03/04/2020
  Time: 22:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registati</title>
</head>
<body>

<jsp:include page="WEB-INF/header.jsp"></jsp:include>

<div class="pageTitle">
    <h1 class="my-3" align="center">Registrati</h1>
</div>

<div class="container">
    <form method="post" action="registration-servlet" class="verticalForm">
        <div class="rowDiv">
            <input type="text" class="form-control" name="nome" placeholder="Nome">
            <input type="text" class="form-control" name="cognome" placeholder="Cognome">
        </div>
        <div class="rowDiv">
            <input type="text" class="form-control" name="email1" placeholder="Email">
            <input type="text" class="form-control" name="email2" placeholder="Conferma email">
        </div>
        <div class="colDiv">
            <div class="rowDiv">
                <button class="btnGoSecondary m10" type="button" id="button-addon1" onclick="showpwd()">Mostra password</button>
                <input type="password" id="pwd1" name="pwd1" placeholder="Password">
            </div>
            <div class="rowDiv">
                <button class="btnGoSecondary m10" type="button" onclick="showpwd()" id="button-addon2">Mostra password</button>
                <input type="password" id="pwd2" name="pwd2" placeholder="Conferma password">
            </div>
        </div>
        <div class="rowDiv">
            <input type="number" class="form-control" name="telefono" placeholder="Numero di telefono">
            <button type="submit" class="btnGoSecondary">REGISTRATI</button>
        </div>
    </form>
</div>


<script>
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
</script>
</body>
</html>
