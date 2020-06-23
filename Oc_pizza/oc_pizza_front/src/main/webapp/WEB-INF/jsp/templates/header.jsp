<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 01/12/2019
  Time: 23:39
  To change this template use File | Settings | File Templates.
--%>

<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light" style=" background-color: rgba(137, 175, 192, 0.5);">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/home"><img src ="${pageContext.request.contextPath}/img/Logo_Mont.png"></a>
                    <a class="nav-item nav-link active" href="${pageContext.request.contextPath}/home">Accueil <span class="sr-only">(current)</span></a>
                    <a class="nav-item nav-link" href="${pageContext.request.contextPath}/listSites">Sites</a>
                    <c:if test="${sessionScope.user != null}">
                        <a class="nav-item nav-link" href="${pageContext.request.contextPath}/auth/listAllTopos">Topos</a>
                        <a class="nav-item nav-link" href="${pageContext.request.contextPath}/auth/listTopos">Mes topos</a>
                        <a class="nav-item nav-link" href="${pageContext.request.contextPath}/auth/listBookings">Réservations</a>
                    </c:if>
                </div>

            </div>
            <div class="navbar-text" style="float:right;margin-top:20px;">
                             <c:if test="${sessionScope.user.username != null}">
                    <span>Bonjour ${sessionScope.user.username}<span/><br/>
                    <a href="${pageContext.request.contextPath}/logout" tabindex="-1" aria-disabled="true" style="text-decoration:none;">Se déconnecter</a>
                </c:if>

                <c:if test="${sessionScope.user.username == null}">
                     <c:if test="${login_page != true}">
                       <span>Mon compte<span/><br/>
                       <a href="${pageContext.request.contextPath}/login" tabindex="-1" aria-disabled="true" style="text-decoration:none;">Me connecter</a>
                     </c:if>
                </c:if>
            </div>


        </nav>
    </body>
</html>
