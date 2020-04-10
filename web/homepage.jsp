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
    ArrayList<Articolo> articoli = adao.doRetrieveNonVendutiTen();
    int index = 10;
    session.setAttribute("articoli",articoli);
    ArrayList<Album> album = new ArrayList<>();
  %>

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
          <div class="row align-items-center" id="rigaArticolo">
            <div class="col-xl-5 col-md-6">
              <div>
                <%if(album.size()>0){%>
                  <img class="img-fluid" src="<%=album.get(0).getPath()%>" alt="">
                <%}else{%>
                  <img class="img-fluid" src="images/img1.jpg" alt="">
                <%}%>
              </div>
            </div>
            <div class="col-xl-7 col-md-6">
              <div>
                <h3><%=a.getTitolo()%></h3>
                <p class="font-weight-bold"><%=a.getPrezzo()%> euro</p><br>
                <label>Venduto a </label>
                <p class="font-weight-bold"><%=a.getLuogo()%></p>
                <div>
                  <form class="form-inline">
                    <button class="btn btn-outline-dark">Acquista</button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <hr>
  <%}%>
  <div class="container-fluid mx-auto">
    <button id="btnLoadMore" onclick="loadmore()" class="btn btn-success">Carica altri articoli</button>
  </div>

  <script>
    function loadmore(){
      var rigaArticolo = document.getElementById(rigaArticolo);
      var ajax = new XMLHttpRequest();
      console.log("dentro")

      ajax.onreadystatechange = function (){
        if (ajax.readyState == 4 && ajax.status == 200){
          var newItems = JSON.parse(ajax.responseText)
          console.log("items"+newItems);
          for (i = 0; newItems.length; i++){
            var riga = document.createElement("div");
            riga.className="row align-items-center";
            var divFoto = document.createElement("div");
            divFoto.className = "col-xl-5 col-md-6";
            var divArt = document.createElement("div");
            divArt.className = "col-xl-7 col-md-6";

          }
        }
      }

      ajax.open("GET","LoadMore?index=<%=index%>",true);
      <%index+=10;%>
      ajax.send();

    }
  </script>


  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  </body>
</html>
