<%--
  Created by IntelliJ IDEA.
  User: lam99
  Date: 03/12/2019
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Ajouter un lieu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/templates/header.jsp"/>
    <form method="post" action="${pageContext.request.contextPath}/admin/addPlace">
        <div class="form-group">
            <label for="country">Pays</label>
            <input type="text" class="form-control" id="country" name="country" value="<c:out value="${place.country}"/>">
            <span class="errors">${form.errors['country']}</span>
        </div>
        <div class="form-group">
            <label for="region">Région</label>
            <input type="text" class="form-control" id="region" name="region" value="<c:out value="${place.region}"/>">
            <span class="errors">${form.errors['region']}</span>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter</button>
    </form>
</body>
</html>
