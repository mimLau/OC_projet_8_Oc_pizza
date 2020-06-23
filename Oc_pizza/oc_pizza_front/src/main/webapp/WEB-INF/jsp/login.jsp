<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 27/11/2019
  Time: 22:56
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Se connecter</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
        <div style="margin: 1rem;">
            <div class="row">
                <div class="form-group col-sm-4">
                    <br/><span>Je me connecte</span>
                </div>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="text" class="form-control" id="identifier" name="identifier" value=""  placeholder="  Adresse e-mail ou nom d'utilisateur">
                        <span class="errors">${form.errors['identifier']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="password" class="form-control" id="password" name="password" value="" placeholder="  Mot de passe">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <span class="errors">${form.errors['authMess']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <button type="submit" class="btn-primary form-control">Se connecter</button>
                    </div>
                </div>
            </form>
            <div class="row">
                <div class="form-group col-sm-4">
                    <span>Vous n'avez pas de compte?</span>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-sm-4">
                    <button type="button" class="btn form-control" style="border-color: #007bff;"><a href="${pageContext.request.contextPath}/register" style="text-decoration:none;">Créer un compte</a></button>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-sm-4">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/login" style="text-decoration:none;">Retour</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>


        <c:set var="login_disp" value="${true}" scope="application"></c:set>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>
