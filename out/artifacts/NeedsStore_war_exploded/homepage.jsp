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
    <title>Needs.store</title>
    <link rel="stylesheet" type="text/css" href="css/homepagestyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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

  <%
    //carica il catalogo di articoli
    ArticoloDAO adao = new ArticoloDAO();
    AlbumDAO albumDAO = new AlbumDAO();
    ArrayList<Articolo> articoli = adao.doRetrieve(10, 0);
    session.setAttribute("articoli",articoli);
    ArrayList<Album> album = new ArrayList<>();
  %>
  <form>
    <input type="hidden" id="index" name="index" value="10">
  </form>

  <%
    String error = (String)request.getAttribute("error");
    if (error!=null){
  %>
    <div class="divError m20">
      <p style="font-weight: lighter;"><%=error%></p>
    </div>
  <%}%>
  <div class="container100">
    <form action="toAddannuncio" method="post">
      <button type="submit" class="btnGo" id="btnInserisci">INSERISCI ANNUNCIO</button>
    </form>
  </div>

  <%for (Articolo a:articoli) {
      album = albumDAO.doRetrieveByArticolo(a);%>
      <!-- 1article area  -->
      <div>
        <div class="container" id="contenitoreArticoli">
          <div class="riga" id="divArticolo"><!-- div riga-->
            <div>
              <div style="width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;">
                <%if(album.size()>0){%>
                  <img src="${request.contextPath}<%=album.get(0).getPath()%>" style="width: 100%;position: absolute;left: 0;top: 50%;transform: translateY(-50%);">
                <%}else{%>
                  <img src="images/no-image.jpg" style="width: 100%;position: absolute;left: 0;top: 50%;transform: translateY(-50%);">
                <%}%>
              </div>
            </div><!-- div foto-->
            <div class="container">
              <div>
                <h3 class="titolo"><%=a.getTitolo()%></h3>
                <p><%=a.getPrezzo()%> euro - Pubblicato il <%=a.getData_inserimento()%></p><br>
                <p class="luogo"><%=a.getLuogo()%></p>
                <div>
                  <form class="form-inline" action="toPageAcquista">
                    <button class="btnGo" type="submit" name="idArticolo" value="<%=a.getIdArticolo()%>">Acquista</button>
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
  <div>
    <button id="btnLoadMore" class="btnGo">Carica altri articoli</button>
  </div>

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

    //aggiunta html dinamica di una riga articolo
    function doRest(resp){
      console.log("putting "+resp.titolo+" "+resp.prezzo+" con album "+album[0].path);

      var container = document.createElement("div");
      container.className="container";

      var riga = document.createElement("div");
      riga.className="riga";

      var divFoto = document.createElement("div");
      if (album[0].path!="empty"){
        divFoto.innerHTML += "<img style=\"width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;\" src="+album[0].path+" alt=\"\">";
      }else{
        divFoto.innerHTML += "<img style=\"width: 300px;height: 300px;overflow: hidden;position: relative;background: rgb(107,149,149);margin: 10px 0;\" src="+"images/no-image.jpg"+" alt=\"\">";
      }

      var divArt = document.createElement("div");
      divArt.className = "container";
      divArt.innerHTML += "<div><h3 class='titolo'>"+resp.titolo+"</h3>\n" +
              "                <p>"+resp.prezzo+" euro - Pubblicato il "+resp.data_inserimento+"</p><br>\n" +
              "                <label>Luogo </label>\n" +
              "                <p class='luogo'>"+resp.luogo+"</p>\n" +
              "                <div>\n" +
              "                  <form class='form-inline' action=\"toPageAcquista\">\n" +
              "                    <button class=\"btnGo\" type=\"submit\" name=\"idArticolo\" value="+resp.idArticolo+">Acquista</button>\n" +
              "                  </form></div>";

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

  <link rel="stylesheet" type="text/css" href="css/mystyle.css">
  </body>
</html>
