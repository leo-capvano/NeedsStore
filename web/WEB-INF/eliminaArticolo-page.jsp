<%@ page import="model.ArticoloDAO" %>
<%@ page import="model.Articolo" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 07/07/2020
  Time: 02:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Elimina Articolo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>

<%
    String idArticolo = (String) request.getAttribute("idArticolo");
    ArticoloDAO ardao = new ArticoloDAO();
    Articolo artToDelete = ardao.doRetrieveById(idArticolo);
%>


<div class="pageTitle" style="margin:10px;">
    <h1 style="margin-bottom: 50px;">Perchè vuoi eliminare l'articolo <span style="color: #1e7e34"><%=artToDelete.getTitolo()%></span>?</h1>
</div>

<div class="rowDiv divError mg-bottom-20" id="div-error">
    <p id="error-message"></p>
</div>

<div class="rowDiv">
    <button id="butSell" value="<%=artToDelete.getIdArticolo()%>" class="btnGo" style="height: 20rem;width: 25rem;margin-right: 10px;" onclick="sellArticle()">Venduto</button>
    <button id="butDel" value="<%=artToDelete.getIdArticolo()%>" class="btnGo" style="height: 20rem;width: 25rem;margin-right: 10px;" onclick="delArticle()">Altro</button>
</div>


<script>

    var div_error = document.getElementById("div-error");
    var error_message = document.getElementById("error-message")
    div_error.style.visibility = "hidden"
    div_error.style.opacity = 0;
    div_error.style.transition = "visibility, opacity 500ms"
    var artToDel = document.getElementById("butSell").value;
    console.log(artToDel)

    //chiedi conferma(sei sicuro?)
    //vendi l'articolo, chiama servlet inserisci record vendita
    //elimina record db articoli
    //vai alla homepage
    function sellArticle() {
        if (confirm("Confermi di aver venduto questo articolo?")){
            //chiama servlet vendi
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState==4 && xhr.status==200){
                    //ricevi responseText
                    if (xhr.responseText=="ok"){
                        alert("Articolo eliminato correttamente!")
                        window.location.href="homepage.jsp";
                    }else{
                        div_error.style.visibility = "visible";
                        error_message.innerText = "Errore nell'eliminazione dell'articolo"
                    }
                }
            }
            xhr.open("GET","sellArticle?idArticolo="+artToDel, true);
            xhr.send()
        }
    }

    //chiedi conferma
    //elimina record articoli
    //vai alla homepage
    function delArticle() {
        if(confirm("Vuoi davvero eliminare questo articolo?")){
            //elimina
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState==4 && xhr.status==200){
                    console.log(xhr.responseText)
                    if (xhr.responseText == "1"){
                        alert("Articolo eliminato correttamente!")
                    }else{
                        div_error.style.visibility = "visible";
                        div_error.style.opacity = 1;
                        error_message.innerText = "Errore nell'eliminazione dell'articolo"
                    }
                }
            }
            xhr.open("GET","delArticle?idArticolo="+artToDel,true);
            xhr.send();
        }
    }


</script>


<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<link rel="stylesheet" type="text/css" href="css/secondaryStyle.css">
</body>
</html>
