<%@ page import="model.Utente" %><%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 13/06/2020
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <title>Errore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
    if (utenteLoggato!=null){
%>
    <jsp:include page="WEB-INF/headerLogged.jsp"></jsp:include>
<%}else{%>
    <jsp:include page="WEB-INF/header.jsp"></jsp:include>
<%}%>


<div class="pageTitle">
    <h1>Si è verificato un errore</h1>
</div>
<div class="rowDiv divError">
    <p><%=exception.getMessage()%></p>
</div>


</body>
</html>
