<%@ page import="model.Articolo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Album" %>
<%@ page import="model.Utente" %>
<%@ page import="model.UtenteDAO" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 12/04/2020
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Acquista - Needs.store</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script
            src="https://www.paypal.com/sdk/js?client-id=AdWIywAKHDiGJVQFS9dHN2QZw1j9q28x5VwtXohg8feYVf6il7auCY5w2s_jhUtVx72h2VnNzfcyMXoZ"> // Required. Replace SB_CLIENT_ID with your sandbox client ID.
    </script>

</head>
<body>



<%
    Articolo articolo = (Articolo) request.getAttribute("articolo");
    ArrayList<Album> album = (ArrayList<Album>) request.getAttribute("album");
    UtenteDAO udao = new UtenteDAO();
    Utente venditore = udao.doRetrieveByEmail(articolo.getEmail_vend());

    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>

<h1>ACQUISTA <%=articolo.getTitolo()%></h1>
<div class="container col-5">
    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
        <%if(album!=null){
            for(int i =0; i<album.size(); i++){
                if (i==0){%>
                    <div class="carousel-item active">
                        <img src="<%=album.get(i).getPath()%>" class="d-block w-100">
                    </div>
                <%}else{%>
                    <div class="carousel-item">
                        <img src="<%=album.get(i).getPath()%>" class="d-block w-100">
                    </div>
        <%}}}else{%>
            <div class="carousel-item active">
                <img src="images/no-image.jpg" class="d-block w-100">
            </div>
        <%}%>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
        <span class="carousel-control-next-icon"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
</div>

<div class="container mx-auto my-4">
    <%if (venditore.getTelefono()!=null){%>
        <button class="btn btn-outline-dark" id="contattaSms" onclick="smscontact()">Invia un SMS</button>
        <p class="font-weight-bold" id="telefono" hidden><%=venditore.getTelefono()%></p>
        <a href="https://wa.me/15551234567?text=Ciao%20<%=venditore.getNome()%>%20ti%20contatto%20per%20il%20tuo%20annuncio%20su%20Needs.store:%20<%=articolo.getTitolo()%>">
            <button class="btn btn-success" id="whatsapp" hidden>Messaggia su whatsapp</button>
        </a>
    <%}%>
    <button class="btn btn-outline-dark" id="contattaEmail" onclick="emailcontact()">Invia una e-mail</button>
    <p class="font-weight-bold" id="email" hidden><%=venditore.getEmail()%></p>

</div>


<script type="text/javascript">

    function emailcontact() {

    }

    function smscontact(){
        var telefono = document.getElementById("telefono");
        var whatsappBtn = document.getElementById("whatsapp");
        if (telefono.hidden==true){
            telefono.hidden = false;
            whatsappBtn.hidden = false;
        }else{
            telefono.hidden = true;
            whatsappBtn.hidden = true;
        }
    }


    $('.carousel').carousel()
</script>

</body>
</html>
