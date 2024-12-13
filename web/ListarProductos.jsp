<%-- 
    Document   : ListarProductos
    Created on : 20/11/2024, 4:11:58 p. m.
    Author     : esteb
--%>
<%@page import="domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    
        <title>Listar Productos</title>
    </head>
    <body>
         
         <%
            List<Product> products = new ArrayList();

            if (session.getAttribute("products") != null) {
                products = (List<Product>) session.getAttribute("products");
            }
        %>
        
         <div class="container">
            <h1>Productos ( <%= products.size()%> )</h1>

            <div class="form-row">
                <div class="col-md-12">
                    <table class="table table-bordered">
                        <tr>
                            <td>Codigo</td>
                            <td>Nombre</td>
                            <td>Cantidad</td>
                            <td>Precio</td>
                            <td></td>
                        </tr>

                        <%
                            for (Product item : products) {
                        %>
                        <tr>
                            <td><%= item.getCodigo()%></td>
                            <td><%= item.getNombre()%></td>
                            <td><%= item.getCantidad()%></td>
                            <td><%= item.getPrecio()%></td>
                            <td><img src="<%= item.getImagen()%>" height="50px" width="50px" /></td>
                        </tr>
                        <%
                            }
                        %>

                    </table>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3">
                    <a class="btn-outline-primary btn" href="CrearProducto.jsp">Volver</a>
                </div>
            </div>

        </div>

    </body>
</html>
