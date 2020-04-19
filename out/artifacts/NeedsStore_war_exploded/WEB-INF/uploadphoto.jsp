<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 04/04/2020
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Aggiungi Foto</title>
</head>
<body>
<div class="container">
    <div class="card my-3 mx-auto" style="width: 20rem;">
        <img class="card-img-top" src="images/img1.jpg" alt="Card image cap">
        <div class="card-body">
            <p class="card-text">Carica la foto</p>
        </div>
    </div>
    <form action="UploadImage" method="post" enctype="multipart/form-data">
        <div class="custom-file">
            <input type="file" name="fileuploaded" class="custom-file-input" id="customFile" multiple="multiple">
            <label class="custom-file-label" for="customFile">Carica foto</label>
        </div>
        <div class="my-3 mx-auto">
            <button class="btn btn-outline-success" type="submit">AVANTI</button>
        </div>
    </form>
</div>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

</body>
</html>
