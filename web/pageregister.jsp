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



<h1 class="my-3" align="center">Registrati</h1>
<div class="container">
    <form method="post" action="registration-servlet">
        <div class="row mx-sm-1 my-sm-1">
            <div class="col">
                <input type="text" class="form-control" name="nome" placeholder="Nome">
            </div>
            <div class="col">
                <input type="text" class="form-control" name="cognome" placeholder="Cognome">
            </div>
        </div>
        <div class="row mx-sm-1 my-sm-1">
            <div class="col">
                <input type="text" class="form-control" name="email1" placeholder="Email">
            </div>
            <div class="col">
                <input type="text" class="form-control" name="email2" placeholder="Conferma email">
            </div>
        </div>
        <div class="row mx-sm-1 my-sm-1">
            <div class="input-group my-sm-1">
                <div class="input-group-prepend">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon1" onclick="showpwd()">Mostra password</button>
                </div>
                <input type="password" id="pwd1" class="form-control" name="pwd1" placeholder="Password" aria-label="Example text with button addon" aria-describedby="button-addon1">
            </div>
            <div class="input-group my-sm-1">
                <div class="input-group-prepend">
                    <button class="btn btn-outline-secondary" type="button" onclick="showpwd()" id="button-addon2">Mostra password</button>
                </div>
                <input type="password" id="pwd2" class="form-control" name="pwd2" placeholder="Conferma password" aria-label="Example text with button addon" aria-describedby="button-addon1">
            </div>
        </div>
        <div class="row mx-sm-1 my-sm-1">
            <div class="col">
                <input type="number" class="form-control" name="telefono" placeholder="Numero di telefono">
            </div>
        </div>
        <div class="row mx-auto my-sm-3">
            <button type="submit" class="btn btn-outline-dark">REGISTRATI</button>
        </div>
    </form>
</div>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
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
