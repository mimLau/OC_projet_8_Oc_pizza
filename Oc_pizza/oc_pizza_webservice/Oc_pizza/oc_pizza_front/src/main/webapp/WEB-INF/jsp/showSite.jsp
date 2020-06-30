<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 10/12/2019
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Site - <c:out value="${site.name}"></c:out></title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script>
        window.onload = function() {
          var appBanners = document.getElementsByClassName('editComForm');
          for (var i = 0; i < appBanners.length; i ++) {
                appBanners[i].style.display = 'none';
          }
        }

        function showEditCommForm( clickedButtnNb ) {
            document.getElementById("form_" + clickedButtnNb).style.display = 'block';
        }

        function cancelEdition( form_nb) {
            document.getElementById("form_" + form_nb).reset();
            document.getElementById("form_" + form_nb).style.display = 'none';
        }
    </script>
</head>
    <body>
        <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
        <br/><div class="text-center"><h3 class="card-title">Site - <c:out value="${site.name}"></c:out></h3></div><br/><br/>

        <div class="outer-div">

            <div class="col-sm-10" style="margin:0 auto;">
                <h6 class="card-subtitle mb-2 text-muted">Description du site:</h6>
                <div >
                    <p class="text-justify"><c:out value="${site.description}"></c:out></p>
                </div><br/>
            </div>

            <br/>
            <div class="col-sm-10" style="margin:0 auto;">
                <c:choose>
                    <c:when test="${!empty site.sectors}">
                        <p>Ce site présente différents secteurs, dont vous trouverez  la liste dans le tableau ci-dessous.</p><br/>
                            <table class="table table-hover" style="border: 1px solid #DDD;">
                                <tr>
                                    <th>Nom du secteur</th>
                                    <th>Nombre de voies</th>
                                </tr>
                                <c:forEach items="${site.sectors}" var="sector">
                                    <tr>
                                        <td> <a style="text-decoration: none" href="${pageContext.request.contextPath}/showSector?id=${sector.id}"><c:out value="${sector.name}"/></a></td>
                                        <td><c:out value="${sector.nbOfWays}"></c:out></td>
                                    </tr>
                                </c:forEach>
                            </table>

                    </c:when>
                    <c:otherwise>
                        <p class="text-center"> Aucun secteur n'a été ajouté pour ce site.</p><br/>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="col-sm-10" style="margin:0 auto;">
                <div style="float:left">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/listSites" style="text-decoration:none;">Retour</a></li>
                        </ul>
                    </nav>
                </div>
                <div style="float: right">
                    <c:if test="${sessionScope.user.username != null}">
                        <div><a class="btn btn-secondary" href="${pageContext.request.contextPath}/auth/addSector">Ajouter un secteur</a></div><br/>
                    </c:if>
                </div>
            </div>

            <br/><br/>

            <div class="col-sm-10" style="margin:0 auto;">
                <p class="text-center">
                        <c:if test="${! empty site.comments}">
                            <c:choose>
                                <c:when test="${fn:length(site.comments) gt 1}">${fn:length(site.comments)} COMMENTAIRES </c:when>
                                <c:otherwise>
                                    ${fn:length(site.comments)} COMMENTAIRE
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${empty site.comments}">
                            Il n'y a pas de commentaire.
                        </c:if>
                </p><br/>
                <div >
                    <c:if test="${! empty site.comments}">
                            <c:forEach items="${site.comments}" var="comment" varStatus="nb">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">
                                        <span><c:out value="${fn:toUpperCase(comment.commentOwner.username)}"/></span><br/>
                                        <span style="font-size: xx-small"><c:out value="${comment.date}"/></span><br/><br/>
                                        <c:out value="${comment.contents}"/><br/>
                                        <c:if test="${comment.edited == true}">
                                            <br/><span style="font-size: x-small;float:right;">Edité le: <c:out value="${comment.editedDate}"/><br/></span>
                                        </c:if>
                                        <br/>
                                        <c:if test="${sessionScope.user.role == 'MEMBRE' || sessionScope.user.role == 'ADMIN'}">
                                            <a class="btn btn-secondary btn-sm"  href="${pageContext.request.contextPath}/auth/deleteComm?id=${comment.id}" style="background-color:rgba(178, 201, 211, 0.9);border:none;">Supprimer</a>
                                            <button type="submit" class="btn btn-secondary btn-sm" onclick="showEditCommForm( <c:out value="${nb.index}"></c:out> )" style="background-color:rgba(178, 201, 211, 0.9);border:none;">Editer</button>

                                            <form class="editComForm" method="post" action="${pageContext.request.contextPath}/auth/updateComm?id=${comment.id}" id="form_<c:out value="${nb.index}"></c:out>">
                                                <br/>
                                                <textarea name="comment_edit_contents" rows="5" placeholder="Votre commentaire" aria-required="true" style="width:100%;"> <c:out value="${comment.contents}"/></textarea>
                                                <div class="form-group" style="padding-top: 2px;">
                                                    <input type="submit" class="submit btn-sm" value="Valider" style="color:white;background-color:rgba(162, 165, 167 , 0.5);border:none;">
                                                    <input type="button"  class="submit btn-sm" value="Annuler" onclick="cancelEdition( <c:out value="${nb.index}"></c:out> )" style="color:white;background-color:rgba(162, 165, 167 , 0.5);border:none;">
                                                </div>
                                            </form>
                                        </c:if>
                                    </li>
                                </ul>
                            </c:forEach>
                    </c:if>
                </div>
            </div>

            <div class="col-sm-10" style="margin:0 auto;"><br/>
                <c:if test="${sessionScope.user.username != null}">
                    <div class="text-center"><h3 class="card-title">Laisser un commentaire</h3></div><br/>
                    <form method="post" action="${pageContext.request.contextPath}/auth/addComment">
                        <textarea name="comment_contents" style="width:100%;" rows="5" placeholder="Votre commentaire" aria-required="true"></textarea>
                        <div class="form-group" style="padding-top:2px;">
                            <div style="float:left">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/listSites" style="text-decoration:none;">Retour</a></li>
                                    </ul>
                                </nav>
                            </div>
                            <div style="float: right">
                                <button type="submit" class="btn-sm btn-primary">Publier</button>
                            </div>

                        </div>
                    </form>
                </c:if>
            </div>

        </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>
