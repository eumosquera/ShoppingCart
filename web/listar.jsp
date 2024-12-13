<%-- 
    Document   : listar
    Created on : 5/12/2024, 10:51:48 p. m.
    Author     : esteb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Producto"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"  crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="dist/sweetalert.js"></script>
        <link rel="stylesheet" href="dist/sweetalert.css">
        <title>Listar Productos</title>

    </head>
    <body>

        <% if (request.getAttribute("message") != null) {%>

        <input type="text" id="message" value="<%= request.getAttribute("message")%>" hidden="" />
        <input type="text" id="type" value="<%= request.getAttribute("type")%>" hidden="" />
        <script>
            var message = document.getElementById("message").value;
            var type = document.getElementById("type").value;
            swal("Notificación", message, type);
        </script>

        <%}%> 

        <div class="container mt-3">
            <div class="card">
                <div class="card-body">
                    <h1>LISTADO DE PRODUCTOS</h1>
                    <hr>
                    <a href="CrearProducto.jsp" class="btn btn-success btn-sm">
                        <i class="fa fa-plus-circle"></i> Nuevo
                    </a>
                    <a href="ProductController?accion=listar" class="btn btn-info btn-sm">
                        <i class="fa-solid fa-arrows-rotate"></i> Refrescar
                    </a>
                    <table class="table table-bordered table-striped mt-2">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Genero</th>
                                <th>Categoria</th>
                                <th>Imagen</th>
                                <th>Accion</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${productos}" var="item">
                                <tr>
                                    <td>${item.prodCodigo}</td>
                                    <td>${item.prodNombre}</td>
                                    <td>${item.prodCantidad}</td>
                                    <td>${item.prodPrecio}</td>
                                    <td>${item.prodGenero}</td>
                                    <td>${item.prodCategoria}</td>
                                    <td><img src="${item.prodImagen}" height="50px" width="50px" /></td>

                                    <td>
                                        <a href="ProductController?accion=editar&prodCodigo=${item.prodCodigo}"
                                           class="btn btn-info btn-sm">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="ProductController?accion=eliminar&prodCodigo=${item.prodCodigo}"
                                           onclick="return confirm('Está seguro que desea eliminar el producto con Codigo ${item.prodCodigo}')"
                                           class="btn btn-danger btn-sm">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>

                            </c:forEach>
                            <c:if test="${productos.size() == 0}">
                                <tr class="text-center">
                                    <td colspan="6">No hay registros</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
