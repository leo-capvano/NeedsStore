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

<section id="cover" class="min-vh-100">
    <div id="cover-caption">
        <div class="container">
            <div class="row text-white">
                <div class="col-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto text-center form p-4">
                    <h1 class="display-4 py-2 text-truncate">Center my form.</h1>
                    <div class="px-2">
                        <form action="login" method="post" class="justify-content-center">
                            <div class="form-group">
                                <input name="email" type="text" class="form-control" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <input name="pwd" type="password" class="form-control" placeholder="Password">
                            </div>
                            <button type="submit" class="btn btn-outline-dark btn-lg">Accedi</button>
                        </form>
                        <%if (errorLogin!=null){%>
                            <div class="alert alert-danger" role="alert">
                                Email o password errata!
                            </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>



<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
</body>
</html>
