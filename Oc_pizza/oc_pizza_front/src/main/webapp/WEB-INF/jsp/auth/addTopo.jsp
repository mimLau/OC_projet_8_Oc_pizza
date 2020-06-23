<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 24/12/2019
  Time: 12:39
  To change this template use File | Settings | File Templates.
--%>
<html>
    <head>
        <title>Ajouter un topo</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
        <div class="outer-div">
            <div class= "col-sm-4" style="margin:0 auto;">
                <br/><p class="text-center font-weight-bold"> Ajouter un topo</p>
                <form method="post" action="${pageContext.request.contextPath}/auth/addTopo">
                    <div class="form-group">
                        <label for="topoName">Nom du topo</label>
                        <input type="text" name="topoName" class="form-control" id="topoName">
                        <label for="topoDesc">Description</label>
                        <textarea type="text" name="topoDesc" class="form-control" id="topoDesc"></textarea>
                        <label for="topoDate">Date de parution</label>
                        <input type="date" name="topoDate" class="form-control" id="topoDate">
                    </div>
                    <button type="submit" name="AddTopo" class="btn btn-secondary">Ajouter</button>
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
