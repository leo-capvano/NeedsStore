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
<html>
<head>
    <title>Acquista - Needs.store</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
</head>
<body>



<%
    Articolo articolo = (Articolo) request.getAttribute("articolo");
    ArrayList<Album> album = (ArrayList<Album>) request.getAttribute("album");
    UtenteDAO udao = new UtenteDAO();
    Utente venditore = udao.doRetrieveByEmail(articolo.getEmail_vend());

    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>

<div class="pageTitle">
    <h1>ACQUISTA <%=articolo.getTitolo()%></h1>
</div>

<div class="rowDiv">
    <div class="galleryPic">
        <%if(album!=null){
            for(int i =0; i<album.size(); i++){
                if (i==0){%>
                    <img src="<%=album.get(i).getPath()%>" style="width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;">
                <%}else{%>
                    <img src="<%=album.get(i).getPath()%>" style="width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;">
                <%}}}else{%>
                <img src="images/no-image.jpg" class="imgSquare">
        <%}%>
    </div>

    <a class="perc" onclick="scorri(-1)">&#10094;</a>
    <a class="succ" onclick="scorri(1)">&#10095;</a>
</div>

<div>
    <%if (venditore.getTelefono()!=null){%>
        <button id="contattaSms" onclick="smscontact()">Invia un SMS</button>
        <p id="telefono" hidden><%=venditore.getTelefono()%></p>
        <a href="https://wa.me/15551234567?text=Ciao%20<%=venditore.getNome()%>%20ti%20contatto%20per%20il%20tuo%20annuncio%20su%20Needs.store:%20<%=articolo.getTitolo()%>">
            <button id="whatsapp" hidden>Messaggia su whatsapp</button>
        </a>
    <%}%>
    <button id="contattaEmail" onclick="emailcontact()">Invia una e-mail</button>
    <p id="email" hidden><%=venditore.getEmail()%></p>

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

</script>

</body>
</html>
