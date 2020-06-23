<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 27/12/2019
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<html>
    <head>
        <title>Tableau de réservations</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive_table.css">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>

            <div class="outer-div">
                    <div class="responsive-table-line" style="margin:0px auto;max-width:1000px;">
                    <c:choose>
                        <c:when test="${! empty bookings}">
                            <br/>
                            <p class="text-center"> Réservations de mes topos</p><br/>
                            <table class="table table-hover" style="border: 1px solid #DDD;">
                                <thead>
                                    <tr>
                                        <th>Nom du topo</th>
                                        <th>Demandeur</th>
                                        <th>Adresse email</th>
                                        <th>Statut</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${bookings}" var="booking">
                                        <tr>
                                            <td data-title="Non du topo"><c:out value="${booking.topo.name}"></c:out></td>
                                            <td data-title="Demandeur"><c:out value="${booking.userRequest.username}"></c:out></td>
                                            <td data-title="Adresse e-mail"><c:out value="${booking.userRequest.email}"></c:out></td>
                                            <td data-title="Statut">
                                                <c:if test="${booking.status == 'IN_PROGRESS'}">
                                                    En attente
                                                </c:if>
                                                <c:if test="${booking.status == 'ACCEPTED'}">
                                                    Acceptée
                                                </c:if>
                                                <c:if test="${booking.status == 'EXPIRED'}">
                                                    expirée
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${booking.status == 'IN_PROGRESS'}">
                                                    <c:if test="${booking.topo.borrowed != true}">
                                                        <button type="button" class="btn btn-secondary" style="width:115px;background-color:rgba(160, 161, 162, 0.8);border:none;"><a style="text-decoration:none;color:white;" href="${pageContext.request.contextPath}/auth/validateBooking?id=${booking.id}">Valider</a></button>
                                                    </c:if>

                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <br/>
                            <p class="text-center">Il n'y a aucune demande de réservation.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
