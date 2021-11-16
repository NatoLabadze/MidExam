<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>

<% if(request.getParameter("is_successful") != null &&
        request.getParameter("is_successful").equals("yes")) { %>
<p>Information written into DB successfully!</p>
<% } %>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost/ug_db"
                   user = "root"  password = "12345" />

<sql:query dataSource = "${snapshot}" var = "result">
    SELECT * from VACANCIES;
</sql:query>

<br>

<table border="1" width="100%">

    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Type</th>
        <th>Salary</th>
    </tr>

    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><c:out value="${row.id}" /></td>
            <td><c:out value="${row.title}" /></td>
            <td><c:out value="${row.description}" /></td>
            <td><c:out value="${row.type}" /></td>
            <td><c:out value="${row.salary}" /></td>
        </tr>
    </c:forEach>

</table>

<a href="data.jsp">Add New</a>

</body>
</html>