<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 24/12/2019
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>
<html>
    <head>
        <title>Mes topos</title>
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
                    <c:when test="${! empty topos}">
                        <br/><br/>
                        <p class="text-center"> Mes topos enregistrés</p><br/>
                        <table class="table" style="border: 1px solid #DDD;">
                            <thead>
                                <tr >
                                    <th>Nom du topo</th>
                                    <th>Disponibilité</th>
                                </tr>
                            </thead>
                            <tbody
                                <c:forEach items="${topos}" var="topo">
                                    <tr>
                                        <td data-title="Nom du topo"> <c:out value="${topo.name}"></c:out></td>
                                        <td data-title="Disponibilité">
                                            <c:if test="${topo.borrowed == true}">
                                                <button type="button" class="btn btn-secondary" title="Cliquez pour rendre le topo disponible" style="width:115px;background-color:rgba(160, 161, 162, 0.8);border:none;"><a style="text-decoration:none;color:white;" href="${pageContext.request.contextPath}/auth/updateTopo?id=${topo.id}&disp=false">Indisponible</a></button>
                                            </c:if>
                                            <c:if test="${topo.borrowed == false}">
                                                <button type="button" class="btn btn-secondary" title="Cliquez pour rendre le topo indisponible" style="width:115px;background-color:rgba(160, 161, 162, 0.8);border:none;"><a style="text-decoration:none;color:white;" href="${pageContext.request.contextPath}/auth/updateTopo?id=${topo.id}&disp=true">Disponible</a></button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Vous n'avez enregistré aucun topo.</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="margin:0px auto;max-width:1000px;">
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/auth/addTopo" tabindex="-1" aria-disabled="true">Ajouter un topo</a>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
