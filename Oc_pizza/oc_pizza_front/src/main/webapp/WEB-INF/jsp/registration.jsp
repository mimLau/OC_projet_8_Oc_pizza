<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 27/11/2019
  Time: 22:07
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>S'enregistrer</title>
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
                    <span>Je crée mon compte</span>
                </div>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/register">
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="text" class="form-control" id="username" name="username" value="<c:out value="${user.username}"/>" placeholder="  Nom d'utilisateur">
                        <span class="errors">${form.errors['username']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="text" class="form-control" id="firstname" name="firstname" value="<c:out value="${user.firstname}"/>" placeholder="  Nom">
                        <span class="errors">${form.errors['firstname']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="text" class="form-control" id="lastname" name="lastname" value="<c:out value="${user.lastname}"/>" placeholder="  Prénom">
                        <span class="errors">${form.errors['lastname']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="email" class="form-control" id="email" name="email" value="<c:out value="${user.email}"/>" placeholder="  Adresse e-mail">
                        <span class="errors">${form.errors['email']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="password" class="form-control" id="password" name="password" placeholder="  Mot de passe">
                        <span class="errors">${form.errors['password']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <input type="password" class="form-control" id="passConf" name="passConf" placeholder="  Confirmation du mot de passe">
                        <span class="errors">${form.errors['passConf']}</span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-sm-4">
                        <button type="submit" class="btn-primary form-control">Créer votre compte</button>
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
            </form>
        </div>

        <c:set var="login_disp" value="${false}" scope="application"></c:set>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
