<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Articolo" %>
<%@ page import="model.Utente" %><%--
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
    ArrayList<Articolo> articoli = (ArrayList<Articolo>) session.getAttribute("articoli");
  %>

  <div class="container">
    <form action="toAddannuncio" method="post">
      <button type="submit" class="btn btn-outline-success btn-lg btn-block">INSERISCI ANNUNCIO</button>
    </form>
  </div>

  <%for (Articolo a:articoli) {
      if (a.getEmail_acq()==null){%>
      <!-- 1article area  -->
      <div class="about_area">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-xl-5 col-md-6">
              <div>
                <img class="img-fluid" src="images/img3.jpg" alt="">
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
  <%}}%>



  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  </body>
</html>
