<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 03/12/2019
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<head>
    <title>Ajouter un site d'escalade</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
</head>
    <body>
          <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
          <br/>
          <div class="outer-div">

                  <p class="text-center font-weight-bold"> Ajouter un nouveau site</p><br/>

                  <form method="post" action="${pageContext.request.contextPath}/auth/addSite">
                      <div class="col-sm-4" style="margin:0 auto;">
                          <div class="form-group">
                              <label for="siteName">Nom du site</label>
                              <input type="text" class="form-control" id="siteName" name="name">
                          </div>
                          <div class="form-group">
                            <label for="selectPlace">Lieu</label>
                            <select class="form-control" id="selectPlace" name="region">
                                <c:forEach items="${countryRegions}" var="countryRegion">
                                    <optgroup label="${countryRegion.key}">
                                        <c:forEach items="${countryRegion.value}" var="item" varStatus="loop">
                                            <option  value="${item}">${item}</option>
                                        </c:forEach><br>
                                    </optgroup>
                                </c:forEach>
                            </select>
                          </div>
                          <div>
                            <label for="description">Description</label>
                            <textarea id="description" name="description" style="width:100%;"></textarea>
                          </div>
                      </div>
                      <div class="col-sm-4" style="margin:0 auto;">
                          <div style="float:left">
                              <nav aria-label="Page navigation example">
                                  <ul class="pagination">
                                      <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/listSites" style="text-decoration:none;">Retour</a></li>
                                  </ul>
                              </nav>
                          </div>
                          <div style="float: right">
                              <button type="submit" name="AddSite" class="btn btn-primary">Ajouter</button>
                          </div>
                      </div>
                   </form>

              </div>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>
