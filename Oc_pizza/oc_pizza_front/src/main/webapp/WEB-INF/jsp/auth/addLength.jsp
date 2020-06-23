<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 14/12/2019
  Time: 22:35
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<head>
    <title>Ajouter un site d'escalade</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
</head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>

        <div class="outer-div">

            <div class="col-sm-10" style="margin:0 auto;">
                <br/><div class="text-center"><h3 class="card-title">Voie - <c:out value="${way.name}"></c:out></h3></div><br/>
            </div>

            <div class= "col-sm-4" style="margin:0 auto;">
            <form method="post" action="${pageContext.request.contextPath}/auth/addLength">
                <p class="text-center"> Ajouter une nouvelle longueur</p><br/>
                <div class="form-group">
                    <label for="lengthName">Nom de la longueur</label>
                    <input type="text" name="lengthName" class="form-control" id="lengthName">
                </div>
                <div class="form-group">
                    <label for="lengthLength">Longeur</label>
                    <input type="number" name="lengthLength" class="form-control" id="lengthLength">
                </div>
                <div class="form-group">
                    <label for="rating">Cotation</label>
                    <select class="form-control" id="rating" name="rating" >
                        <option value=""> -- Choisissez une cotation --  </option>
                        <c:forEach items="${ratings}" var="rating">
                            <option value="${rating}"> ${rating}  </option>
                        </c:forEach>
                    </select>
                </div>
                <div style="float:left">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/showWay?id=${way.id}" style="text-decoration:none;">Retour</a></li>
                        </ul>
                    </nav>
                </div>
                <div style="float: right">
                    <button type="submit" name="AddLength" class="btn btn-primary">Ajouter</button>
                </div>
            </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>