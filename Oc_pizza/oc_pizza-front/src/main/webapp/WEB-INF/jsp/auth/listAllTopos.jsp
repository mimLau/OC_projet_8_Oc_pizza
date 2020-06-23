<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 24/12/2019
  Time: 12:28
  To change this template use File | Settings | File Templates.
--%>
<html>
    <head>
        <title>Liste des topos</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive_table.css">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
        <br/>
        <div class="outer-div">
            <div class="responsive-table-line" style="margin:0px auto;max-width:1000px;">
                <c:choose>
                    <c:when test="${! empty topos}">
                        <br/>
                        <p class="text-center">Nos amis de l'escalade vous proposent les topos suivants :</p>
                        <br/>
                        <table class="table table-hover" style="border: 1px solid #DDD;">
                            <thead>
                                <tr>
                                    <th>Nom du topo</th>
                                    <th>Description</th>
                                    <th>Date de parution</th>
                                    <th>Disponibilité</th>
                                    <th>Propriétaire</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${topos}" var="topo">
                                    <tr>
                                        <td data-title="Nom du topo"><c:out value="${topo.key.name}"></c:out></td>
                                        <td data-title="Description"><c:out value="${topo.key.description}"/></td>
                                        <td data-title="Date de parution"><c:out value="${topo.key.releaseDate}"/></td>
                                        <td data-title="Disponibilité">
                                            <c:if test="${topo.key.borrowed == false}">
                                            Disponible
                                            </c:if>
                                            <c:if test="${topo.key.borrowed == true}">
                                                Indisponible
                                            </c:if>
                                        </td>
                                        <td data-title="propriétaire"><c:out value="${topo.key.topoOwner.username}"/></td>
                                        <td data-title="">
                                            <c:if test="${topo.key.borrowed == false}">
                                                <c:choose>
                                                    <c:when  test="${topo.value == false}">
                                                        <c:if test="${topo.key.topoOwner.username != sessionScope.user.username }">
                                                            <button type="button" class="btn btn-secondary" style="width:115px;background-color:rgba(160, 161, 162, 0.8);border:none;"><a style="text-decoration:none;color:white;" href="${pageContext.request.contextPath}/auth/bookingTopo?id=${topo.key.id}">Réserver</a></button>
                                                        </c:if>
                                                        <c:if test="${topo.key.topoOwner.username == sessionScope.user.username }">
                                                            <button type="button" class="btn btn-secondary" style="width:115px;background-color:rgba(167, 173, 176 , 0.4);border:none;cursor:default;color:#D8D5D5;" title="Vous ne pouvez pas réserver votre propre topo.">Réserver</button>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-secondary" style="width:115px;background-color:rgba(167, 173, 176 , 0.4);cursor:default;border:none;color:#D8D5D5;" title="Une demande de réservation est déjà en cours.">Réserver</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <c:if test="${topo.key.borrowed == true}">
                                                <c:choose>
                                                    <c:when test="${topo.key.topoOwner.username == sessionScope.user.username }">
                                                        <button type="button" class="btn btn-secondary" style="width:115px;border:none;background-color:rgba(167, 173, 176 , 0.4);color:#D8D5D5;cursor: default;" title="Topo indisponible. Vous ne pouvez pas réserver votre propre topo.">Réserver</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-secondary" style="width:115px;border:none;background-color:rgba(167, 173, 176 , 0.4);color:#D8D5D5;cursor: default;" title="Topo indisponible.">Réserver</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Il n'y aucun topo d'enregistré.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
