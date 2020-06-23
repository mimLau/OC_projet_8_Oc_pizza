<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 11/12/2019
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<html>
    <head>
        <title>Secteur - ${sector.name}</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive_table.css">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
        <div class="outer-div">
            <div class="responsive-table-line" style="margin:0px auto;max-width:1200px;"><br/>
                <div class="text-center"><h3 class="card-title">Secteur - <c:out value="${sector.name}"></c:out></h3>
                </div><br/>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item" style="list-style-type: none">Site: <c:out value="${site.name}"></c:out></li>
                        <li class="list-group-item" style="border-bottom: none"><h6 class="card-subtitle mb-2 text-muted">Description du secteur :</h6><br/>
                            <p class="text-justify">Integer malesuada elit vel massa porttitor sodales quis ut tellus. Nullam bibendum ante sed nulla iaculis rutrum. Suspendisse nec porttitor magna. In hac habitasse platea dictumst. Aenean quis lorem in orci fermentum laoreet vitae eu felis. Ut aliquet dui at quam fermentum, eget tincidunt magna sagittis. Aenean ut urna at ante viverra pulvinar. Sed luctus elit turpis, nec efficitur augue pretium a. Mauris et lacinia leo. Morbi posuere convallis leo, ornare tempor neque. Sed lobortis risus quis vehicula ultrices. Pellentesque gravida est non eros varius lobortis.</p>
                        </li><br/><br/>
                    </ul>
            </div>
            <div class="outer-div">
                <div class="responsive-table-line" style="margin:0px auto;max-width:1200px;">
                    <c:choose>
                        <c:when test="${!empty sector.ways}">
                            <p class="text-center"> Liste des voies existantes :</p><br/>
                                <table class="table table-hover" style="border: 1px solid #DDD;">
                                    <thead>
                                        <tr>
                                            <th>Nom de la voie</th>
                                            <th>Longueur</th>
                                            <th>Cotation</th>
                                            <th>Nombre de longueurs</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sector.ways}" var="way">
                                            <tr>
                                                <td data-title="Nom de la voie"><a style="text-decoration: none" href="${pageContext.request.contextPath}/showWay?id=${way.id}"><c:out value="${way.name}"/></a></td>
                                                <td data-title="Longueur"><c:out value="${way.length}"/></td>
                                                <td data-title="Cotation"><c:out value="${way.rating}"/></td>
                                                <td data-title="Nombre de longueurs"><c:out value="${way.nbOfLengths}"/></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center"> Aucune voie n'a été ajoutée pour ce secteur.</p><br/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="margin:0px auto;max-width:1200px;">
                    <div style="float:left">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/showSite?id=${site.id}" style="text-decoration:none;">Retour</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div style="float: right">
                        <c:if test="${sessionScope.user.username != null}">
                            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/auth/addWay">Ajouter une voie</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
