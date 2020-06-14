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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
</head>
<body>

<jsp:include page="headerLogged.jsp"></jsp:include>


<div class="chapterTitle centerDiv">
    <p>Carica delle foto dell'articolo</p>
</div>

<div class="rowDiv centerDiv">
    <form action="UploadImage" method="post" enctype="multipart/form-data">
        <div class="divFileWrapper mg-bottom-20" style="z-index: 0;">
            <input type="file" name="fileuploaded" style="z-index: 2;position: relative;top: 15px;" class="inputFile" id="fileuploaded" multiple>
            <p class="pFileLoadLabel" style="z-index: 1;">CARICA FOTO</p>
        </div>
        <div class="rowDiv">
            <button class="btnGo" type="submit">AVANTI</button>
        </div>
    </form>
    <div class="rowDiv m20">
        <span id="total" class="spancounter">0</span>
    </div>
</div>


</body>
<script>

    $("#fileuploaded").change(function () {
        $("#total").html($("#fileuploaded")[0].files.length)
    })

</script>
</html>
