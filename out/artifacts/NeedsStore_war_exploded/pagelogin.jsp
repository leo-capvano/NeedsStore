<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 03/04/2020
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Accedi al tuo account</title>
</head>
<body>
<%
    String errorLogin = (String)request.getAttribute("errorLogin");
%>

<jsp:include page="WEB-INF/header.jsp"></jsp:include>

<div class="pageTitle">
    <h1>Accedi a Needs.store</h1>
</div>

<div class="rowDiv">
    <div class="loginContainer" id="formContainer">
        <form action="login" method="post" class="verticalForm">
            <input id="email" name="email" type="email" class="focusOutline" placeholder="Email">
            <input id="pwd" name="pwd" type="password" class="focusOutline" placeholder="Password">
            <button type="submit" class="btnGo" id="btnAccedi">Accedi</button>
        </form>
        <%if (errorLogin!=null){%>
        <div class="divError">
            <p>Email o password errata!</p>
        </div>
        <%}%>
    </div>
</div>


<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<link rel="stylesheet" type="text/css" href="css/loginStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</body>

<script>

</script>
</html>
