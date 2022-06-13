<%-- 
    Document   : test logout
    Created on : May 14, 2022, 2:34:21 PM
    Author     : Ehab Attia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    System.out.println("log out page: ");
    Classes.DataBase db=(Classes.DataBase)session.getAttribute("db");
    db.closeDBConnection();
    session.invalidate();
    System.out.println(session.getId());
    //response.sendRedirect("index.jsp");
    
%>
<jsp:forward page="index.jsp"/>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
