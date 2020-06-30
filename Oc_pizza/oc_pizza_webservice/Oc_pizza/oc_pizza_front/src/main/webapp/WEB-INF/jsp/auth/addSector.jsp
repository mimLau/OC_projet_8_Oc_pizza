<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 10/12/2019
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<head>
    <title>Ajouter un secteur</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
</head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>


        <div class="outer-div">

            <div class="col-sm-10" style="margin:0 auto;">
                <br/><div class="text-center"><h3 class="card-title">Site - <c:out value="${site.name}"/></h3></div><br/>
            </div>

            <p class="text-center"> Ajouter un nouveau secteur</p><br/>

                <form method="post" action="${pageContext.request.contextPath}/auth/addSector">

                    <div class= "col-sm-4" style="margin:0 auto;">
                        <div class="form-group">
                            <label for="sectorName">Nom du secteur</label>
                            <input type="text" name="sectorName" class="form-control" id="sectorName">
                        </div>
                    </div>

                    <div class="col-sm-4" style="margin:0 auto;">
                        <div style="float:left">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/showSite?id=${site.id}" style="text-decoration:none;">Retour</a></li>
                                </ul>
                            </nav>
                        </div>
                        <div style="float: right">
                            <button type="submit" name="AddSector" class="btn btn-primary">Ajouter</button>
                        </div>
                    </div>

                </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
