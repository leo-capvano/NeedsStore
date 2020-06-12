<%@ page import="model.Utente" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 02/04/2020
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>

<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>

<nav>
    <a href="index.html" id="brand">Needs.store</a>
    <label for="toggle">&#9776;</label>
    <input type="checkbox" id="toggle">
    <div class="menu">
        <form action="logout-servlet" class="inlineForm">
            <button type="submit">Logout</button>
        </form>
        <form action="cerca-servlet" class="inlineForm">
            <button type="submit" name="button">Cerca</button>
        </form>
    </div>
</nav>

<link rel="stylesheet" type="text/css" href="css/mystyle.css">
</body>

<script type="text/javascript">

</script>

</body>
</html>
