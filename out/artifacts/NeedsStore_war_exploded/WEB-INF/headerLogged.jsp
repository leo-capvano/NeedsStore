<%@ page import="model.Utente" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 02/04/2020
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/errorPage.jsp" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
</head>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<body>
<nav>
    <a href="index.html" id="brand">Needs.store</a>
    <label for="toggle" style="margin-right: 10px">&#9776;</label>
    <a id="userLoggedNav" style="float: left; font-size: 15px; margin-left: 10px;margin-top: 2px;">${utenteLoggato.email}</a>
    <input type="checkbox" id="toggle">
    <div class="menu">
        <form action="shaw-account" class="inlineForm">
            <button type="submit" class="btnGo">Account</button>
        </form>
        <form action="logout-servlet" class="inlineForm">
            <button type="submit" class="btnGo">Logout</button>
        </form>
        <form class="inlineForm" action="toPreferite">
            <button type="submit" name="button" class="navBtn redBtn">Preferiti</button>
        </form>
        <form action="cerca-servlet" class="inlineForm">
            <button type="submit" name="button" class="btnGo">Cerca</button>
        </form>
        <%if(utenteLoggato.isAdmin()){%>
        <form class="inlineForm" action="adminPage">
            <button type="submit" name="btnAdmin" value="btnAdmin" class="btnGo">ADMIN</button>
        </form>
        <%}%>
    </div>
</nav>

</body>
</html>
