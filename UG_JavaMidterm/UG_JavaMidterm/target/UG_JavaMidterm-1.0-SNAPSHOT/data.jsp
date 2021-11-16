<%@ page import="com.example.ug_javamidterm.Vacancy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Vacancy</title>
</head>
<body>

<form method="post">
    Title: <input id="vacancyTitle" type="text" name="title"><br/>
    Description: <input id="vacancyDescription" type="text" name="description"><br/>
    Type: <input id="vacancyType" type="text" name="type"><br/>
    Salary: <input id="vacancySalary" type="number" name="salary"><br/>
    <button type="submit">Submit</button>
</form>

<%
    Vacancy vacancy = new Vacancy();

    if(request.getParameter("title") != null
            && request.getParameter("description") != null
            && request.getParameter("type") != null
            && request.getParameter("salary") != null) {

        vacancy.setTitle(request.getParameter("title"));
        vacancy.setDescription(request.getParameter("description"));
        vacancy.setType(request.getParameter("type"));
        vacancy.setSalary(Integer.parseInt(request.getParameter("salary")));


        session.setAttribute("title", vacancy.getTitle());
        session.setAttribute("description", vacancy.getDescription());
        session.setAttribute("type", vacancy.getType());
        session.setAttribute("salary", vacancy.getSalary());

%>
<script>window.location.href = "check.jsp";</script>
<%
    }
%>

</body>
</html>
