<%--
  Created by IntelliJ IDEA.
  User: leoca
  Date: 04/04/2020
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inserisci il tuo annuncio</title>
</head>
<body>
<div class="container">
    <form method="get" action="toUploadphoto">
        <div class="form-group">
            <label for="titolo">Titolo dell'annuncio</label>
            <input type="text" class="form-control" id="titolo" name="titolo" placeholder="titolo">
        </div>
        <div class="form-group">
            <label for="exampleFormControlTextarea1">Descrizione</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="descrizione"></textarea>
        </div>
        <div class="form-row">
            <div class="form-group col-lg-10 col-sm-10">
                <label for="luogo">Luogo</label>
                <input type="text" class="form-control" id="luogo" name="luogo">
            </div>
            <div class="form-group col-lg-2 col-sm-2">
                <label for="luogo">Prezzo</label>
                <input type="number" class="form-control" id="prezzo" name="prezzo">
            </div>
        </div>
        <div class="form-row">
            <div class="container col-12">
                <button type="submit" class="btn btn-outline-success">AVANTI</button>
            </div>
        </div>
    </form>
</div>



<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

</body>
</html>
