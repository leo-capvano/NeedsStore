<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 02/04/2020
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=11" />
    <title>Needs.store</title>
  </head>
  <%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
  %>

  <%if(utenteLoggato==null){%>
    <jsp:include page="WEB-INF/header.jsp"></jsp:include>
  <%}else{%>
    <jsp:include page="WEB-INF/headerLogged.jsp"></jsp:include>
  <%}%>

  <body>
  <script type="text/css" src="css/myStyle.css"></script>
  <%
    //carica il catalogo di articoli
    ArticoloDAO adao = new ArticoloDAO();
    AlbumDAO albumDAO = new AlbumDAO();
    ArrayList<Articolo> articoli = adao.doRetrieveNonVendutiTen();
    session.setAttribute("articoli",articoli);
    ArrayList<Album> album = new ArrayList<>();
  %>
  <form>
    <input type="hidden" id="index" name="index" value="10">
  </form>
  <div class="container">
    <form action="toAddannuncio" method="post">
      <button type="submit" class="btn btn-outline-success btn-lg btn-block">INSERISCI ANNUNCIO</button>
    </form>
  </div>

  <%for (Articolo a:articoli) {
      album = albumDAO.doRetrieveByArticolo(a);%>
      <!-- 1article area  -->
      <div class="about_area">
        <div class="container" id="contenitoreArticoli">
          <div class="row align-items-center" id="divArticolo"><!-- div riga-->
            <div class="col-xl-5 col-md-6">
              <div style="width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;">
                <%if(album.size()>0){%>
                  <img src="<%=album.get(0).getPath()%>" style="width: 100%;position: absolute;left: 0;top: 50%;transform: translateY(-50%);">
                <%}else{%>
                  <img src="images/no-image.jpg" style="width: 100%;position: absolute;left: 0;top: 50%;transform: translateY(-50%);">
                <%}%>
              </div>
            </div><!-- div foto-->
            <div class="col-xl-7 col-md-6">
              <div>
                <h3><%=a.getTitolo()%></h3>
                <p class="font-weight-bold"><%=a.getPrezzo()%> euro - Pubblicato il <%=a.getData_inserimento()%></p><br>
                <label>Luogo </label>
                <p class="font-weight-bold"><%=a.getLuogo()%></p>
                <div>
                  <form class="form-inline" action="toPageAcquista">
                    <button class="btn btn-outline-dark" type="submit" name="idArticolo" value="<%=a.getIdArticolo()%>">Acquista</button>
                  </form>
                </div>
              </div>
            </div><!-- div art-->
          </div>
        </div>
      </div>
      <hr>
  <%}%>
  <div id="articles" class="about_area">

  </div>
  <div class="container-fluid mx-auto">
    <button id="btnLoadMore" class="btn btn-success">Carica altri articoli</button>
  </div>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  <script type="text/javascript">
    var album = "no";
    var root = document.getElementById("articles");

    //caricamento articoli non ancora visualizzati
    $("#btnLoadMore").click(function(){
      jQuery.ajax({
        type:"POST",
        url:"LoadMore",
        dataType:"json",
        data:{ index: $("#index").val()},
        success: function(resp){
          myFunction(resp);
        }
      })
    });

    //main loop
    function myFunction(resp){

      if (resp[0].titolo!="empty"){
        for (i=0; i<resp.length; i++){

          loadAlbum(resp[i].idArticolo, resp[i]);

        }

        var indexNum = parseInt(document.getElementById("index").value);
        indexNum = indexNum + 10;
        document.getElementById("index").value = indexNum;
      }
      console.log("index: "+document.getElementById("index").value)
    }

    //aggiunta html dinamica
    function doRest(resp){
      console.log("putting "+resp.titolo+" "+resp.prezzo+" con album "+album[0].path);

      var container = document.createElement("div");
      container.className="container";

      var riga = document.createElement("div");
      riga.className="row align-items-center my-3";

      var divFoto = document.createElement("div");
      divFoto.className = "col-xl-5 col-md-6";
      if (album[0].path!="empty"){
        divFoto.innerHTML += "<img class=\"img-fluid\" style=\"width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;\" src="+album[0].path+" alt=\"\">";
      }else{
        divFoto.innerHTML += "<img class=\"img-fluid\" style=\"width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;\" src="+"images/no-image.jpg"+" alt=\"\">";
      }

      var divArt = document.createElement("div");
      divArt.className = "col-xl-7 col-md-6";
      divArt.innerHTML += "<h3>"+resp.titolo+"</h3>\n" +
              "                <p class=\"font-weight-bold\">"+resp.prezzo+" euro - Pubblicato il "+resp.data_inserimento+"</p><br>\n" +
              "                <label>Luogo </label>\n" +
              "                <p class=\"font-weight-bold\">"+resp.luogo+"</p>\n" +
              "                <div>\n" +
              "                  <form class=\"form-inline\">\n" +
              "                    <button class=\"btn btn-outline-dark\">Acquista</button>\n" +
              "                  </form>";

      riga.appendChild(divFoto);
      riga.appendChild(divArt);
      container.appendChild(riga)
      root.append(container);
      root.innerHTML += "<hr>";
    }

    //ricerca album per ogni articolo
    function loadAlbum(idArticolo, resp){
      //console.log("looking for articole "+resp.titolo)

      var ajaxjs = new XMLHttpRequest();
      ajaxjs.open("GET","LoadAlbum?idArticolo="+idArticolo,true);
      ajaxjs.send();

      ajaxjs.onreadystatechange = function(){
        if (ajaxjs.readyState==4 && ajaxjs.status==200){
            album = JSON.parse(ajaxjs.responseText);
            doRest(resp);
        }else{
          //console.log("not ok con "+resp.titolo+" rd: "+ajaxjs.readyState+" status: "+ajaxjs.status);
        }
      }
    }

  </script>

  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

  </body>
</html>
