<%-- 
    Document   : refresh.jsp
    Created on : 10/12/2024, 10:58:36 a. m.
    Author     : esteb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
                    
                     response.sendRedirect("ProductController?accion=listar");
                     //response.sendRedirect("WordDocument2Servlet");
                %>
    </body>
</html>
