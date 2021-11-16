<%@ page import="com.example.ug_javamidterm.Vacancy" %>
<%@ page import="javax.persistence.EntityManagerFactory" %>
<%@ page import="javax.persistence.Persistence" %>
<%@ page import="javax.persistence.EntityManager" %>
<%@ page import="javax.persistence.EntityTransaction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Review Information</title>
</head>
<body>
<h3>Review Information</h3>

<ul>
    <li>
        <p>Title : <%= session.getAttribute("title")%>
        </p>
    </li>
    <li>
        <p>Description : <%= session.getAttribute("description")%>
        </p>
    </li>
    <li>
        <p>Type : <%= session.getAttribute("type")%>
        </p>
    </li>
    <li>
        <p>Salary : <%= session.getAttribute("salary")%>
        </p>
    </li>
</ul>

<form action="check.jsp" method="post">
    <input type="hidden" name="shouldSave" value="yes"/>
    <input type="submit" value="Save">
</form>

<% String isSuccessful = "no"; %>

<%

    if(     session.getAttribute("title") != null
            && session.getAttribute("description") != null
            && session.getAttribute("type") != null
            && session.getAttribute("salary") != null
            && request.getParameter("shouldSave") != null
            && request.getParameter("shouldSave").equals("yes")) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            Vacancy vacancy = new Vacancy();

            vacancy.setTitle(session.getAttribute("title").toString());
            vacancy.setDescription(session.getAttribute("description").toString());
            vacancy.setType(session.getAttribute("type").toString());
            vacancy.setSalary(Integer.parseInt(session.getAttribute("salary").toString()));

            entityManager.persist(vacancy);

            entityTransaction.commit();

            isSuccessful = "yes";

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }


        if(isSuccessful.equals("yes")) { %>

            <form id="finalForm" action="index.jsp" method="post">
                <input type="hidden" name="is_successful" value="<%= isSuccessful %>">
            </form>
            <script>
                document.getElementById("finalForm").submit();
            </script>
<%
        }
    }
%>
</body>
</html>
