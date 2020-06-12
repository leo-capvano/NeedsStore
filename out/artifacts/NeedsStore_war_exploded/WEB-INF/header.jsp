<%--
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

<nav>
    <a href="index.html" id="brand">Needs.store</a>
    <label for="toggle">&#9776;</label>
    <input type="checkbox" id="toggle">
    <div class="menu">
        <button type="button" name="accedi" class="navBtn"><a href="pagelogin.jsp">Accedi</a></button>
        <button type="button" name="button" class="navBtn"><a href="pageregister.jsp">Registrati</a></button>
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
