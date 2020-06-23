<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 30/11/2019
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
    <head>
        <title>Accueil</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
        <div class="row">
            <div class="col-sm-7" style="margin:0 auto;">
                <br/><p class="text-center">Bienvenue sur notre blog!</p>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-7" style="margin:0 auto;">
                <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner" style="margin:0 auto;">
                        <div class="carousel-item active" style="display: block">
                            <img class="d-block w-100" src ="${pageContext.request.contextPath}/img/Escalade_car_1.jpg">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src ="${pageContext.request.contextPath}/img/Escalade_car_2.jpg">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src ="${pageContext.request.contextPath}/img/Escalade_car_3.jpg">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <c:set var="previousPage" value="/home" scope="application"></c:set>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
